class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :tag_translations, :dependent => :destroy
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  # LIKE is used for cross-database case-insensitivity
  def self.find_or_create_with_like_by_name(name)
    find(:first, :conditions => ["name LIKE ?", name]) || create(:name => name)
  end
  
  def ==(object)
    super || (object.is_a?(Tag) && name == object.name)
  end
  
  def to_s
    name
  end
  
  def count
    read_attribute(:count).to_i
  end
  
  def self.localized(id, tag=nil)
    tag = Tag.find(id) if tag.nil?
    current_locale = I18n.locale
    translated_tag = TagTranslation.find_by_language_and_tag_id(current_locale, id)
    unless translated_tag.nil?
      tag = translated_tag 
    else
      logger.info "[INFO] [Tag] No translation for '#{tag.name}' (locale: #{current_locale})"
    end
    tag
  end
  
  def localized
    Tag.localized(self.id, self)
  end
end
