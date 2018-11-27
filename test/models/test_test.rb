require 'test_helper'

class TestTest < ActiveSupport::TestCase
  def test_results
    test = tests(:one)
    question = questions(:one)
    answer = answers(:one)
    assert_equal ({ question => [answer] }), test.results
  end
end
