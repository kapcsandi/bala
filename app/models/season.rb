class Season < ActiveRecord::Base
  attr_accessible :name, :start, :end
  has_many :house_seasons
  has_many :houses, :through => :house_seasons

  default_scope :order => 'start ASC'

  named_scope :next_year, {:conditions => "seasons.end > '#{Date.today.strftime}'"}
  named_scope :for_house, lambda {|house_id| {:joins => :house_seasons, :conditions => {:house_seasons => { :house_id => house_id}}}}
  named_scope :for_all, {:joins => "LEFT OUTER JOIN house_seasons ON (seasons.id = house_seasons.season_id)", :conditions => {:house_seasons => { :house_id => nil}}}
  accepts_nested_attributes_for :house_seasons, :allow_destroy => true #, :reject_if => proc { |a| a['house_id'].blank? }
  
  def self.which_season?(house_id, day=Date.today)
    begin
      if house.seasons.empty?
        self.for_all.next_year.select { |season| (day >= season.start) and (day <= season.end) }[0].name
      else
        self.for_house(house_id).next_year.select { |season| (day >= season.start) and (day <= season.end) }[0].name
      end
    rescue
      logger.info "season error for day: #{day}"
      'main_saison'
    end
  end
end
