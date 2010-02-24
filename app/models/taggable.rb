class Taggable < ActiveRecord::Base
  translates :name, :context
  validates_presence_of :field, :name, :context

  has_many :tags, :dependent => :destroy 
  has_many :houses_taggables
  has_many :houses, :through => :houses_taggables
  default_scope :order => :position, :include => :tags
  named_scope :of_field, lambda{|name| { :conditions => { :field => name } } }
  accepts_nested_attributes_for :tags, :allow_destroy => true, :reject_if => proc { |a| a['name'].blank? }
end
