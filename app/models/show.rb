class Show < ActiveRecord::Base
  validates_presence_of :name

  has_many :episodes

  scope :in_alphabetical_order, -> { order(arel_table[:name].asc) }

  def to_s
    name
  end
end
