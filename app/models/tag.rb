class Tag < ActiveRecord::Base
  translates :name
  
  belongs_to :taggable
  has_many :houses_tags
  has_many :houses, :through => :houses_tags
#  has_many :tag_translations
#  default_scope :joins => :tag_translations
  
  def houses
    House.scoped(:joins => :tags, :conditions => { :tags => { :id => id }})
  end
  
end
