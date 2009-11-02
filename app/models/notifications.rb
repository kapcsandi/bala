class Notifications < ActionMailer::Base
  def signup(member)
    recipients member.email_address_with_name
    from       "istvan.kapcsandi+bala@gmail.com"
    subject    "New account information"
    body       :user => member
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
