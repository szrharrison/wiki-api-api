class DatasetSerializer < ActiveModel::Serializer
  attributes :data

  def data
    object.as_json.keys.each_with_object({}) do |key, obj|
      if key == "_id"
      else
        obj[key] = object[key]
      end
    end
  end
end
