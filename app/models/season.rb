class Season < ActiveRecord::Base
  attr_accessible :name, :start, :end

  named_scope :last_year, {:conditions => "end > #{Date.today.strftime}", :order => 'start ASC'}

  def self.which_season?(day)
    self.last_year.select { |season| (day >= season.start) }.map {|season| season.name}[0]
  end
end
