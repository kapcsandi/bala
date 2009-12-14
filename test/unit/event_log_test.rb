require 'test_helper'

class EventLogTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert EventLog.new.valid?
  end
end
