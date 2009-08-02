class Condition < ActiveRecord::Base

  # állapot
  translates :name
#  has_many :condition_translations 
#  accepts_nested_attributes_for :condition_translations, :allow_destroy => true  

end
