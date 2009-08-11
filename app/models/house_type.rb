class HouseType < ActiveRecord::Base
  # ház típusa
  translates :name
  has_many :houses
end
