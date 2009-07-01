class User < ActiveRecord::Base
  acts_as_authentic
  
  def locale
    I18n.locale
  end
  
  def locale=(loc)
    I18n.locale=loc
  end
end
