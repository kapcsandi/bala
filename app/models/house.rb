class House < ActiveRecord::Base
  translates :house_description, 
    :bedroom_description,
    :kitchen_description,
    :bathroom_description,
    :yard_description,
    :other_description,
    :owner_speaks,
    :owner_place

  belongs_to :house_type
  belongs_to :furnishing
  belongs_to :condition
  has_one :discount, :dependent => :destroy

  accepts_nested_attributes_for :discount, :allow_destroy => true
  
  validates_presence_of :city_id, :house_type, :condition, :furnishing
  
  def discounted?
    if self.discount.nil? or self.discount.new_record?
      false
    else
      true
    end
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
