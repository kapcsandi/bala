class HousesBooking < ActiveRecord::Base
  attr_accessible :house_id, :position, :start_at, :end_at, :status, :notes
  belongs_to :house
  belongs_to :booking, :dependent => :destroy
  belongs_to :owner, :class_name => 'User'
  validates_presence_of :house_id, :start_at, :end_at
  named_scope :with_assoc, {:include => [:house, :booking]}
  named_scope :on_month, lambda{|date| { :conditions => ["start_at >= ? AND end_at <= ?", date.beginning_of_month, date.end_of_month]}}
  named_scope :with_status, lambda {|status| {:conditions => ["status_id IN ( ? )" , status.map{|st| HousesBooking.states.index(st) } ]}}

  has_event_calendar

  def self.states
    [t('status_created'),t('status_approved'),t('status_deleted'),t('status_unknown')]
  end

  def status
    HousesBooking.states[self.status_id]
  end

  def nights
    (self.end_at - self.start_at).to_i if self.end_at and self.start_at
  end

  def name
    self.code
  end

  def nights=(day)
    (self.end_at - self.start_at).to_i if self.end_at and self.start_at
  end

  def status=(status_string)
    self.status_id=HousesBooking.states.index(status_string)
  end

  def price
    self.position.nil? ? 0 : self.position
  end

  def formatted_price
    "%8.2f" % self.price
  end
  
  def price=(value)
    self.position=value
  end

  def code
    if self.booking
      self.id.to_s + "/" + self.booking.id.to_s + '/' + self.house.stripped_code
    else
      self.id.to_s + '/' + self.house.stripped_code
    end
  end
end
