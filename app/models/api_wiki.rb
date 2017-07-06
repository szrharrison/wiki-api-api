class ApiWiki
  include Mongoid::Document
  include ActiveModel::Serialization
  include Slugifiable
  field :name, type: String
  field :documentation, type: String
  field :slug, type: String

  validates :slug, uniqueness: {message: ': "%{value}" is already taken'}, exclusion: { in: [ "api", "new", "dataset" ], message: ': "%{value}" is a reserved slug' }

  index({slug: 1}, {unique: true})

  has_many :pages, validate: false, autosave: true, dependent: :destroy do
    def slugs
      @target.map do |page|
        page.slug
      end
    end
    def get_by_slug(slug)
      where(slug: slug)
    end
    def all
      Page.where(relative_path: /^#{base.slug}/) # NOTE: @base (attr reader => base) is the way to refer to the parent document in a relationship extension method. Equivalent to @target which refers to the array of documents that satisfy the relationship
    end
  end

  belongs_to :account, index: true
end

# def combine_nested_pages(pages, all=[])
#   pages.each do |page|
#     all << page
#     if page.sub_pages.count != 0
#       combine_nested_pages(page.sub_pages, all)
#     end
#   end
#   all
# end
