class User < ActiveRecord::Base
  has_many :houses_bookings, :foreign_key => :owner_id
  acts_as_authentic
  
  def locale
    I18n.locale
  end
  
  def locale=(loc)
    I18n.locale=loc
  end
  
  def email_address_with_name
    "#{self.username} <#{self.email}>"
  end

  def admin?
    self.role == 'admin' || self.id == 1
  end
end
