class Booking < ActiveRecord::Base
  attr_accessible :from, :to, :nights, :persons, :with_animals, :notes, :phone, :mobile, :email, :firstname, :lastname, :company, :address, :city, :postcode, :country, :status
  has_many :houses_bookings, :dependent => :destroy
  has_many :houses, :through => :houses_bookings, :uniq => true
  validates_numericality_of :persons, :greater_than => 0
  validates_numericality_of :nights, :greater_than => 0
  validates_presence_of :from, :to, :phone, :email, :firstname, :lastname, :nights
  validates_date :from, :before => :to
  validates_date :to, :after => :from
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates_associated :houses_bookings

  def states 
    [t('status_created'),t('status_approved'),t('status_deleted'),t('status_unknown')]
  end

  def status
    states[self.status_id]
  end  
  
  def status=(status_string)
    self.status_id=states.index(status_string)
  end
end
