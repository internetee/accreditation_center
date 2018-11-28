require 'test_helper'

class ExamTest < ActiveSupport::TestCase
  def test_implements_default_iterator_for_results
    question = questions(:one)
    first_answer = answers(:one)
    second_answer = first_answer.dup
    exam = Exam.new(answered_questions: answered_questions)
    answered_questions = [AnsweredQuestion.new(exam: exam, question: question, answer: first_answer),
                          AnsweredQuestion.new(exam: exam, question: question, answer: second_answer)]
    exam.answered_questions = answered_questions

    iteration_count = 0

    exam.each do |exam_question, exam_answers|
      assert_equal question, exam_question
      assert_equal [first_answer, second_answer], exam_answers
      iteration_count += 1
    end

    assert_equal 1, iteration_count
  end
end
