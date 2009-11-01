require 'test_helper'

class NotificationsTest < ActionMailer::TestCase
  test "signup" do
    @expected.subject = 'Notifications#signup'
    @expected.body    = read_fixture('signup')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notifications.create_signup(@expected.date).encoded
  end

  test "booking" do
    @expected.subject = 'Notifications#booking'
    @expected.body    = read_fixture('booking')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notifications.create_booking(@expected.date).encoded
  end

end
