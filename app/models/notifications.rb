class Notifications < ActionMailer::Base
  def signup(user)
    recipients  user.email_address_with_name
    from       "registration@1xferienhaus.de"
    reply_to   "renata.gerhat@1xferienhaus.de"
    subject    "New account information"
    body       :user => user
    sent_on    Time.now
  end

  def test
    recipients "istvan.kapcsandi@gmail.com"
    from       "test@1xferienhaus.de"
    subject    "test"
    sent_on    Time.now
  end

  def booking(codes, booking, houses_bookings, sent_at = Time.now)
    recipients booking.email
    from       "#{I18n.t(:booking_from, :locale => I18n.locale)}"
    subject    "#{I18n.t(:booking_notification_subject, :code => booking.code, :date => I18n.l(Date.today, :locale => I18n.locale))}"
    reply_to   "renata.gerhat@1xferienhaus.de"
    body       :booking => booking, :codes => codes, :houses_bookings => houses_bookings
    sent_on    sent_at
  end

  def booking_admin(codes, booking, houses_bookings,  sent_at = Time.now)
    recipients "renata.gerhat@1xferienhaus.de"
    from       "buchung@1xferienhaus.de"
    subject    "1xferienhaus.de admin - Foglalás értesítő"
    body       :booking => booking, :codes => codes, :houses_bookings => houses_bookings
    sent_on    sent_at
  end

  def contact(contact, code, sent_at = Time.now)
    recipients "renata.gerhat@1xferienhaus.de" # current_user.email_address_with_name
    from       "#{I18n.t(:contact_from, :locale => I18n.locale)}"
    subject    "1xferienhaus.de admin - Kapcsolatfelvétel"
    body       :contact => contact, :code => code
    sent_on    sent_at
  end
end
