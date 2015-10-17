class Episode < ActiveRecord::Base
  before_validation :set_identifier

  validates_presence_of :show, :title, :season, :number,
    :starts_at, :ends_at
  validates_uniqueness_of :identifier

  scope :newest_first, -> { order(arel_table[:starts_at].desc) }

  def identifier_for_pirate_bay
    "#{show} s#{season.to_s.rjust(2, '0')}e#{number.to_s.rjust(2, '0')} 720p"
  end

  private

  def set_identifier
    return unless show.present? && season.present? && number.present?

    self.identifier = "#{show} #{season}x#{number.to_s.rjust(2, '0')}"
  end
end
