module Slugifiable
  def slugify(string)
    string.strip.downcase.gsub(/[\s\.\/\\]/, '-').gsub(/[^\w-]/, '').gsub(/[-]{2,}/, '-').gsub(/[_]{2,}/, '_').gsub(/[-_]{2,}/, '-').gsub(/\A[-_]/, '').gsub(/[-_]\Z/, '')
  end

  def set_slug
    self.slug = slugify(name)
  end
end
