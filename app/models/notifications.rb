class Notifications < ActionMailer::Base
  def signup(user)
    recipients  user.email_address_with_name
    from       "buchung@1xferienhaus.de"
    subject    "New account information"
    body       :user => user
    sent_on    Time.now
  end
  
  def test
    recipients "istvan.kapcsandi@gmail.com"
    from       "buchung@1xferienhaus.de"
    subject    "test"
    sent_on    Time.now
  end

  def booking(house_codes, booking, houses_booking, sent_at = Time.now)
    recipients booking.email
    from       "buchung@1xferienhaus.de"
    subject    "#{I18n.t(:booking_notification_subject)}"
    body       :booking => booking, :codes => house_codes, :houses_booking => houses_booking
    sent_on    sent_at
  end

  def booking_admin(house_codes, booking, houses_booking,  sent_at = Time.now)
    recipients  User.first.email_address_with_name
    from       "buchung@1xferienhaus.de"
    subject    "1xferienhaus.de admin - Foglalás értesítő"
    body       :booking => booking, :codes => house_codes, :houses_booking => houses_booking
    sent_on    sent_at
  end
end
