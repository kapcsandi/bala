require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "signup" do
    @expected.subject = 'Notifier#signup'
    @expected.body    = read_fixture('signup')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notifier.create_signup(@expected.date).encoded
  end

end
