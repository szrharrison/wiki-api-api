class VisiblePageSerializer < ActiveModel::Serializer
  attributes :name, :relative_path, :data, :slug

  def data
    data = {}
    if object.dataset
      object.dataset.as_json.keys.each_with_object(data) do |key, obj|
        if key == "_id"
        else
          obj[key] = object.dataset[key]
        end
      end
    end
  end

  has_many :sub_pages, each_serializer: :visible_sub_page_serializer
end
