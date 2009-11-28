class Season < ActiveRecord::Base
  attr_accessible :name, :start, :end

  named_scope :last_year, {:order => :start, :limit => 5}

end
