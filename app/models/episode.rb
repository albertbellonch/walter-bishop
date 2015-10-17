class Episode < ActiveRecord::Base
  validates_presence_of :show, :title, :season, :number,
    :starts_at, :ends_at
  validates_uniqueness_of :identifier

  before_validation :set_identifier
  after_create :enqueue_torrent_download

  scope :oldest_first, -> { order(arel_table[:starts_at].asc) }
  scope :newest_first, -> { order(arel_table[:starts_at].desc) }

  scope :upcoming, -> { where(arel_table[:starts_at].gteq(Time.now)) }

  def to_s
    identifier
  end

  def term_for_torrent_site
    "#{show} s#{season.to_s.rjust(2, '0')}e#{number.to_s.rjust(2, '0')} 720p"
  end

  private

  def set_identifier
    return unless show.present? && season.present? && number.present?

    self.identifier = "#{show} #{season}x#{number.to_s.rjust(2, '0')}"
  end

  def enqueue_torrent_download
    Episode::TorrentDownloadWorker.enqueue_at(start_at + 6.hours, id)
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
      *show, identifier = info.split(" ")
      season, number = identifier.split("x")

      create title: title, show: show.join(' '),
        season: season, number: number,
        starts_at: event.dtstart, ends_at: event.dtend
    end
  end
end
