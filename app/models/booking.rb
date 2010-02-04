class Booking < ActiveRecord::Base
  attr_accessible :nights, :persons, :with_animals, :notes, :admin_notes, :status, :phone, :mobile, :email, :firstname, :lastname, :company, :address, :city, :postcode, :country, :children, :children_years, :animal_details, :salut, :fax, :price
  has_many :houses_bookings, :dependent => :destroy
  has_many :houses, :through => :houses_bookings, :uniq => true, :order => "houses_bookings.position", :select => "houses.*,houses_bookings.position"

#  validates_associated :houses_bookings, :houses
  validates_numericality_of :persons, :greater_than => 0, :unless => :skip_validation
  validates_numericality_of :nights, :greater_than => 0
  validates_numericality_of :price, :greater_than => 0, :unless => :skip_validation
  validates_presence_of :phone, :email, :firstname, :lastname, :nights, :city, :postcode, :address, :unless => :skip_validation
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create, :unless => :skip_validation
  accepts_nested_attributes_for :houses_bookings, :allow_destroy => true, :reject_if => :all_blank

  def code
    'R' + self.id.to_s
  end

  @@states =  [t('status_created'),t('status_approved'),t('status_deleted'),t('status_unknown')]

  def status
    self.houses_bookings.first.status
  end

  def admin_notes
    self.houses_bookings.first.notes
  end


  def start_at
    self.houses_bookings.first.start_at
  end

  def end_at
    self.houses_bookings.first.end_at
  end

  def status=(status_string)
    if self.houses_bookings and self.houses_bookings.first
      self.houses_bookings.first.status_id=@@states.index(status_string)
    else
      0
    end
  end

  def admin_notes=(notes_string)
    if self.houses_bookings and self.houses_bookings.first
      self.houses_bookings.first.notes=notes_string
    else
      ''
    end
  end

  def name
    self.firstname + ' ' + self.lastname
  end

  def houses_bookings_attributes=(attributes)
    logger.info "booking model save: #{attributes.inspect}"
  end

  def country_name(locale = :hu)
    t(:countries, :locale => locale).select{
      |country|
    country[0] == self.country.to_sym
    }[0][1] unless self.country.empty?
  end

#  private
  def skip_validation
    UserSession.find && UserSession.find.record
  end
end