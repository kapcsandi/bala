require 'test_helper'

class DiscountTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Discount.new.valid?
  end
end
