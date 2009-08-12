class HousesTaggable < ActiveRecord::Base
  belongs_to :house
  belongs_to :taggable
end
