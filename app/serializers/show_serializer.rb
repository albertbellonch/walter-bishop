class ShowSerializer < ActiveModel::Serializer
  attributes :name, :episodes_count

  def episodes_count
    object.episodes.count
  end
end
