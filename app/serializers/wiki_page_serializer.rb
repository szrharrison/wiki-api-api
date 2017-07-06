class WikiPageSerializer < ActiveModel::Serializer
  attributes :name, :relative_path
end
