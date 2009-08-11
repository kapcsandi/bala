class Discount < ActiveRecord::Base
  translates :description
  belongs_to :house
end
