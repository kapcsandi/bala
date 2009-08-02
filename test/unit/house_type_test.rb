require 'test_helper'

class HouseTypeTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert HouseType.new.valid?
  end
end
