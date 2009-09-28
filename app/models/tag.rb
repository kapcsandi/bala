class Tag < ActiveRecord::Base
  translates :name
  
  belongs_to :taggable
  has_many :houses_tags
  has_many :houses, :through => :houses_tags
  
  def houses
    House.scoped(:joins => :tags, :conditions => { :tags => { :id => id }})
  end
end
