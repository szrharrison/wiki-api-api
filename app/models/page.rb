class Page
  include Mongoid::Document
  include ActiveModel::Serialization
  include Slugifiable

  field :name, type: String
  field :slug, type: String
  field :data_type, type: String
  field :relative_path, type: String

  validates :name, :slug, :relative_path, presence: true
  validates :api_wiki, presence: true, if: :has_no_parent?
  validates :parent_page, presence: true, if: :has_no_api_wiki?
  validates :relative_path, uniqueness: {message: ': That page already exists'}
  validates :slug, exclusion: { in: [ "dataset", "new", "edit" ], message: ': "%{value}" is a reserved slug' }


  before_validation :set_relative_path
  before_validation :set_dataset

  belongs_to :api_wiki, optional: true
  belongs_to :parent_page, class_name: 'Page', inverse_of: 'sub_pages', index: true, optional: true
  embeds_one :dataset

  index({relative_path: 1}, {unique: true})

  has_many :sub_pages, class_name: 'Page', inverse_of: 'parent_page', dependent: :destroy, validate: false, autosave: true do
    def slugs
      @target.map { |page| page.slug  }
    end

    def get_by_slug(slug)
      @target.select do |page|
        page.slug == slug
      end
    end
  end

  def set_relative_path
    if slug
      add_relative_path
    else
      set_slug
      add_relative_path
    end
  end

  def has_no_parent?
    !parent_page?
  end

  def has_no_api_wiki?
    !api_wiki?
  end

  def set_dataset
    if !dataset
      self.dataset = Dataset.new()
    end
  end

  private
  def add_relative_path
    if has_no_parent?
      self.relative_path = api_wiki.slug + '/' + slug
    else
      self.relative_path = parent_page.relative_path + '/' + slug
    end
  end
end
