class Furnishing < ActiveRecord::Base
  translates :name
  has_many :houses
end
