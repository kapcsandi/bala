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
end
