class HousesBooking < ActiveRecord::Base
  attr_accessible :house_id, :position, :start_at, :end_at, :status
  belongs_to :house
  belongs_to :booking, :dependent => :destroy
  belongs_to :owner, :class_name => 'User'
  acts_as_list
#  validates_presence_of :house_id, :start_at, :end_at
  named_scope :with_assoc,  {:include => [:house, :booking]}
  named_scope :on_month, lambda{|date| { :conditions => ["start_at >= ? AND end_at <= ?", date.beginning_of_month, date.end_of_month]}}

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
    self.house.code
  end

  def nights=(day)
    (self.end_at - self.start_at).to_i if self.end_at and self.start_at
  end

  def status=(status_string)
    self.status_id=HousesBooking.states.index(status_string)
  end
  
end
