class RoomType < ActiveRecord::Base
  translates :name
  has_many :houses
end
