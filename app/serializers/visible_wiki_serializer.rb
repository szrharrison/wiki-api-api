class VisibleWikiSerializer < ActiveModel::Serializer
  attributes :name, :slug, :owner

  def owner
    object.account.username
  end

  has_many :pages, each_serializer: :visible_page_serializer
end
