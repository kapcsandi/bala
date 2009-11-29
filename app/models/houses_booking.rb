class HousesBooking < ActiveRecord::Base
  attr_accessible :position
  belongs_to :house
  belongs_to :booking
  acts_as_list
end
