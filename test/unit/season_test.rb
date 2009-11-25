require 'test_helper'

class SeasonTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Season.new.valid?
  end
end
