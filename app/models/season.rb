class Season < ActiveRecord::Base
  attr_accessible :name, :start, :end
  default_scope :order => 'start ASC'

  named_scope :next_year, {:conditions => "seasons.end > '#{Date.today.strftime}'"}

  def self.which_season?(day)
    begin
      self.next_year.select { |season| (day >= season.start) and (day <= season.end) }[0].name
    rescue
      logger.info "season error for day: #{day}"
      'main_saison'
    end
  end
end
