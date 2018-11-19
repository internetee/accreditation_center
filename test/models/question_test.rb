require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  setup do
    @question = questions(:one)
  end

  def test_fixture_is_valid
    assert @question.valid?
  end

  def test_invalid_without_text_en
    @question.text_en = ''
    assert @question.invalid?
  end

  def test_invalid_without_text_et
    @question.text_en = ''
    assert @question.invalid?
  end

  def test_to_s
    question = Question.new(text_en: 'Why?')
    assert_equal 'Why?', question.to_s
  end
end
