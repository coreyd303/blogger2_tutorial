class Article < ActiveRecord::Base
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings

  def tag_list
    self.tags.collect do |tag|
      tag.name
    end.join(", ")
  end             # interesting code...

  def tag_list=(tags_string)
    # split the tags string into an array of strings with leading and trailing white space
    # then, ensure that each one is unique
    tag_names = tags_string.split(",").collect{ |s| s.strip.downcase }.uniq
    # look for at tag object with that name, if there isn't one make it
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    # add the tag object to a list of tags  for the article
    self.tags = new_or_found_tags
  end
end
