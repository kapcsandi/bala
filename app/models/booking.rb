class Booking < ActiveRecord::Base
  attr_accessible :nights, :persons, :with_animals, :notes, :phone, :mobile, :email, :firstname, :lastname, :company, :address, :city, :postcode, :country, :children, :children_years, :animal_details, :salut, :fax, :price
  has_many :houses_bookings, :dependent => :destroy
  has_many :houses, :through => :houses_bookings, :uniq => true, :order => "houses_bookings.position", :select => "houses.*,houses_bookings.position"

  validates_numericality_of :persons, :greater_than => 0
  validates_numericality_of :nights, :greater_than => 0
  validates_numericality_of :price, :greater_than => 0
  validates_presence_of :phone, :email, :firstname, :lastname, :nights, :city, :postcode, :address
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
#   validates_associated :houses_bookings, :houses
  accepts_nested_attributes_for :houses_bookings, :allow_destroy => true, :reject_if => :all_blank

  def code
    'R' + self.id.to_s
  end

  def states
    self.houses_bookings.first.states
  end

  def status
    self.houses_bookings.first.status
  end

  def start_at
    self.houses_bookings.first.start_at
  end

  def end_at
    self.houses_bookings.first.end_at
  end

  def status=(status_string)
    self.houses_bookings.first.status_id=states.index(status_string)
  end

  def name
    self.firstname + ' ' + self.lastname
  end

  def houses_bookings_attributes=(attributes)
    logger.info "booking model save: #{attributes.inspect}"
  end

  def country_name(locale = :hu)
    t(:countries, :locale => locale).select{|country| country[0] == self.country.to_sym}[0][1]
  end
end