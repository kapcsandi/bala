class Taggable < ActiveRecord::Base
  translates :name
  validates_presence_of :context

  has_many :tags
  has_many :houses_taggables
  has_many :houses, :through => :houses_taggables
  
  accepts_nested_attributes_for :tags, :allow_destroy => true, :reject_if => proc { |a| a['name'].blank? }
end
