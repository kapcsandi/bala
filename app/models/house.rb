class House < ActiveRecord::Base
  translates :house_description

  has_one :discount, :dependent => :destroy
  has_many :houses_taggables
  has_many :taggables, :through => :houses_taggables, :order => :position
  has_many :houses_tags
  has_many :tags, :through => :houses_tags

  accepts_nested_attributes_for :discount, :allow_destroy => true
  accepts_nested_attributes_for :tags, :allow_destroy => true
  
  validates_presence_of :city_id, :house_type_id, :condition_id, :furnishing_id
  
  def discounted?
    if self.discount.nil? or self.discount.new_record?
      false
    else
      true
    end
  end
  
  def city
    Tag.find(city_id).name
  end

  def house_type
    Tag.find(house_type_id).name
  end

  def condition
    Tag.find(condition_id).name
  end

  def furnishing
    Tag.find(furnishing_id).name
  end
#   
#   def client_name
#     client.name if client
#   end
# 
#   def client_name=(name)
#     return nil if name.blank?
#     self.client = Client.find_or_create_by_name_and_agency( name,  0)
#   end
end
