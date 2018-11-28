require 'test_helper'

class ExamTest < ActiveSupport::TestCase
  def test_results
    exam = exams(:one)
    question = questions(:one)
    answer = answers(:one)
    assert_equal ({ question => [answer] }), exam.results
  end
end
