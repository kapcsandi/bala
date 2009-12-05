class Booking < ActiveRecord::Base
  attr_accessible :from, :to, :nights, :persons, :with_animals, :notes, :phone, :mobile, :email, :firstname, :lastname, :company, :address, :city, :postcode, :country, :status, :children, :children_years, :animal_details, :salut, :fax, :price
  has_many :houses_bookings, :dependent => :destroy
  has_many :houses, :through => :houses_bookings, :uniq => true, :order => "houses_bookings.position", :select => "houses.*,houses_bookings.position"
#  has_many :houses, :finder_sql =>
#  'SELECT DISTINCT "houses".*,"houses_bookings"."position" ' +
#      'FROM "houses" ' +
#      'INNER JOIN "houses_bookings"' +
#      'ON "houses".id = "houses_bookings".house_id '+
#      'WHERE (("houses_bookings".booking_id = #{id})) '+
#      'ORDER BY "houses_bookings"."position"'

  validates_numericality_of :persons, :greater_than => 0
  validates_numericality_of :nights, :greater_than => 0
  validates_presence_of :from, :to, :phone, :email, :firstname, :lastname, :nights, :with_animals, :city, :postcode, :address
#  validates_date :from, :before => :to
#  validates_date :to, :after => :from
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates_associated :houses_bookings, :houses
  accepts_nested_attributes_for :houses_bookings, :allow_destroy => true, :reject_if => :all_blank
  def states 
    [t('status_created'),t('status_approved'),t('status_deleted'),t('status_unknown')]
  end

  def status
    states[self.status_id]
  end

  def nights
    (self.to - self.from).to_i if self.to and self.from
  end

  def nights=(day)
    (self.to - self.from).to_i
  end

  def status=(status_string)
    self.status_id=states.index(status_string)
  end

  def name
    self.firstname + ' ' + self.lastname
  end

  private
  def house_code
  end
end