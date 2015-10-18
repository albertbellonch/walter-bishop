class EpisodeSerializer < ActiveModel::Serializer
  attributes :show_id, :title, :season, :number,
    :starts_at, :ends_at, :status, :description
end
