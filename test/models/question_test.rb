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

  def test_inactive_by_default
    question = Question.new
    assert question.inactive?
  end

  def test_active
    question = Question.new(active: true)
    assert question.active?

    question.active = false
    assert_not question.active?
  end

  def test_inactive
    question = Question.new(active: false)
    assert question.inactive?

    question.active = true
    assert_not question.inactive?
  end

  def test_activation
    assert @question.inactive?

    @question.activate
    @question.reload

    assert @question.active?
  end

  def test_deactivation
    @question.activate

    @question.deactivate
    @question.reload

    assert @question.inactive?
  end
end
