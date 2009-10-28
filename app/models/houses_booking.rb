class HousesBooking < ActiveRecord::Base
  belongs_to :house
  belongs_to :booking
  acts_as_list
end
