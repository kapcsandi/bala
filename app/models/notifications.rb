class Notifications < ActionMailer::Base
  def signup(user)
    recipients member.email_address_with_name
    from       "istvan.kapcsandi+bala@gmail.com"
    subject    "New account information"
    body       :user => user
    sent_on    Time.now
  end

  def booking(booking, sent_at = Time.now)
    recipients booking.email
    from       "istvan.kapcsandi+bala@gmail.com"
    subject    t(:booking_notificaton_subject)
    body       :booking => booking
    sent_on    sent_at
    body       :booking => booking
  end

  def booking_admin(booking, sent_at = Time.now)
    recipients  User.first.email_address_with_name
    from       "istvan.kapcsandi+bala@gmail.com"
    subject    "Foglalás érkezett"
    body       :booking => booking
    sent_on    sent_at
  end
end
