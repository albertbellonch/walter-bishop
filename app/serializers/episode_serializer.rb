class EpisodeSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :season, :number,
    :starts_at, :ends_at, :status, :show_id
end
