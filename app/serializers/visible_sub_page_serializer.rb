class VisibleSubPageSerializer < ActiveModel::Serializer
  attributes :name, :slug, :relative_path
end
