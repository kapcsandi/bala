class Notifications < ActionMailer::Base
  def signup(user)
    recipients user.email_address_with_name
    from       "istvan.kapcsandi+bala@gmail.com"
    subject    "New account information"
    body       :user => user
    sent_on    Time.now
  end

  def booking(sent_at = Time.now)
    subject    'Notifications#booking'
    recipients ''
    from       ''
    sent_on    sent_at
    
    body       :greeting => 'Hi,'
  end
end
