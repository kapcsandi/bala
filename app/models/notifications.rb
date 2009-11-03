class Notifications < ActionMailer::Base
  def signup(user)
    recipients  user.email_address_with_name
    from       "istvan.kapcsandi+bala@gmail.com"
    subject    "New account information"
    body       :user => user
    sent_on    Time.now
  end

  def booking(house_codes, booking, sent_at = Time.now)
    recipients booking.email
    from       "istvan.kapcsandi+bala@gmail.com"
    subject    t(:booking_notificaton_subject)
    body       :booking => booking, :codes => house_codes
    sent_on    sent_at
  end

  def booking_admin(house_codes, booking, sent_at = Time.now)
    recipients  User.first.email_address_with_name
    from       "istvan.kapcsandi+bala@gmail.com"
    subject    "Foglalás értesítő"
    body       :booking => booking, :codes => house_codes
    sent_on    sent_at
  end
end
