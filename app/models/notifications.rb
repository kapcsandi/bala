class Notifications < ActionMailer::Base
  def signup(user)
    recipients  user.email_address_with_name
    from       APP_CONFIG['reg_email']
    reply_to   APP_CONFIG['root_email']
    subject    "New account information"
    body       :user => user
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
    recipients APP_CONFIG['root_email']
    from       APP_CONFIG['book_email']
    subject    "admin - Foglalás értesítő"
    body       :booking => booking, :codes => codes, :houses_bookings => houses_bookings
    sent_on    sent_at
  end

  def contact(contact, code, sent_at = Time.now)
    recipients APP_CONFIG['root_email']
    from       "#{I18n.t(:contact_from, :locale => I18n.locale)}"
    subject    "admin - Kapcsolatfelvétel"
    body       :contact => contact, :code => code
    sent_on    sent_at
  end
end
