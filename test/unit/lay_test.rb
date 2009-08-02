require 'test_helper'

class LayTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Lay.new.valid?
  end
end
