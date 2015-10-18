class EpisodeSerializer < ActiveModel::Serializer
  attributes :show, :title, :season, :number,
    :starts_at, :ends_at, :status
end
