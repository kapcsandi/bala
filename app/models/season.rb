class Season < ActiveRecord::Base
  attr_accessible :name, :start, :end
  default_scope :order => 'start ASC'

  named_scope :next_year, {:conditions => "end > #{Date.today.strftime}"}

  def self.which_season?(day)
    self.next_year.select { |season| (day >= season.start) and (day <= season.end) }[0].name
  end
end
