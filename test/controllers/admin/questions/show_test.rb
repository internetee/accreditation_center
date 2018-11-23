require 'test_helper'

class Admin::QuestionsShowTest < ActionDispatch::IntegrationTest
  setup do
    sign_in administrators(:one)
  end

  def test_deactivate_button_is_hidden_when_question_is_inactive
    question = questions(:one)
    assert question.inactive?

    get admin_question_path(question)

    assert_select 'a', count: 0, text: 'Deactivate'
  end

  def test_activate_button_is_hidden_when_question_is_active
    question = questions(:one)
    question.activate

    get admin_question_path(question)

    assert_select 'a', count: 0, text: 'Activate'
  end
end
