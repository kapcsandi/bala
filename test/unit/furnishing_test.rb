require 'test_helper'

class FurnishingTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Furnishing.new.valid?
  end
end
