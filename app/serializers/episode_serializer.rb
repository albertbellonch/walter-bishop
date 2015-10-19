class EpisodeSerializer < ActiveModel::Serializer
  belongs_to :show

  attributes :title, :description, :season, :number,
    :starts_at, :ends_at, :status
end
