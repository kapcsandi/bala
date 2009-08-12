class Tag < ActiveRecord::Base
  translates :name
  
  belongs_to :taggable
  has_many :houses_tags
  has_many :houses, :through => :houses_tags
  
end
