class Notifier < ActionMailer::Base
  def signup(user)
     recipients user.email_address_with_name
     from       "istvan.kapcsandi+bala@gmail.com"
     subject    "New account information"
     body       :user => user
   end
end
