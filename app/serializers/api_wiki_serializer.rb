class ApiWikiSerializer < ActiveModel::Serializer
  attributes :owner, :name, :slug, :pages

  def owner
    object.account.username
  end
  def pages
    object.pages.all.map do |page|
      WikiPageSerializer.new(page).attributes
    end
  end
end
