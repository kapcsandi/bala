class HouseSeason < ActiveRecord::Base
  attr_accessible :house_id, :season_id
  belongs_to :house
  belongs_to :season
end
