class Episode < ActiveRecord::Base
  before_validation :set_identifier

  validates_presence_of :tv_series, :title, :season, :number,
    :start_time, :end_time
  validates_uniqueness_of :identifier

  scope :newest_first, -> { order(arel_table[:start_time].desc) }

  def identifier_for_pirate_bay
    "#{tv_series} s#{season.to_s.rjust(2, '0')}e#{number.to_s.rjust(2, '0')} 720p"
  end

  private

  def set_identifier
    return unless tv_series.present? && season.present? && number.present?

    self.identifier = "#{tv_series} #{season}x#{number.to_s.rjust(2, '0')}"
  end
end
