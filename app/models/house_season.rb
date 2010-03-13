class HouseSeason < ActiveRecord::Base
  attr_accessible :house_id, :season_id
  belongs_to :house
  belongs_to :season

  def self.season_ids
    self.all(:select => 'DISTINCT season_id').map{|hs| hs.season_id}
  end
end
