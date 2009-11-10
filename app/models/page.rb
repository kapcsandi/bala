class Page < ActiveRecord::Base
  translates :title, :body
  validates_presence_of :title
  has_many :page_translations 
  accepts_nested_attributes_for :page_translations, :allow_destroy => true  
  
  def published?
    self.published
  end
end
