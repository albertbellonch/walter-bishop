class Episode < ActiveRecord::Base
  symbolize :status

  validates_presence_of :show, :title, :season, :number,
    :starts_at, :ends_at
  validates_uniqueness_of :identifier

  before_validation :set_identifier
  before_create :set_upcoming_status
  after_create :enqueue_torrent_download

  belongs_to :show, dependent: :destroy, counter_cache: true

  scope :oldest_first, -> { order(arel_table[:starts_at].asc) }
  scope :newest_first, -> { order(arel_table[:starts_at].desc) }

  scope :upcoming, -> { where(arel_table[:starts_at].gteq(Time.now)) }

  def to_s
    identifier
  end

  def term_for_torrent_site
    "#{show} s#{season.to_s.rjust(2, '0')}e#{number.to_s.rjust(2, '0')} 720p"
  end

  %i{ downloading ready }.each do |status|
    define_method "#{status}!" do
      self.status = status
      save!
    end
  end

  private

  def set_identifier
    return unless show.present? && season.present? && number.present?

    self.identifier = "#{show} #{season}x#{number.to_s.rjust(2, '0')}"
  end

  def set_upcoming_status
    self.status = :upcoming
  end

  def enqueue_torrent_download
    Episode::TorrentDownloadWorker.perform_at(starts_at + 6.hours, id)
  end

  class << self
    def fetch_upcoming!
      WalterBishop::Sherlock.upcoming_episodes.map do |event|
        create_from_event!(event)
      end.count(&:persisted?)
    end

    private

    def create_from_event!(event)
      info, title = event.summary.split("-").map(&:strip)
      *show_words, identifier = info.split(" ")
      season, number = identifier.split("x")

      show = Show.find_or_create_by(name: show_words.join(' '))

      create title: title, show: show,
        season: season, number: number,
        starts_at: event.dtstart, ends_at: event.dtend,
        description: event.description
    end
  end
end
