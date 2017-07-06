class PageSerializer < ActiveModel::Serializer
  attributes :name, :relative_path, :data_type, :slug

  has_many :sub_pages, each_serializer: :sub_page_serializer
end
