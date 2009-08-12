class HousesTag < ActiveRecord::Base
  belongs_to :house
  belongs_to :tag
end
