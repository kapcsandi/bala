require 'test_helper'

class RoomTypeTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert RoomType.new.valid?
  end
end
