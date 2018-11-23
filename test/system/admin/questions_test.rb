require 'application_system_test_case'

class Admin::QuestionsTest < ApplicationSystemTestCase
  setup do
    sign_in administrators(:one)
  end

  test 'visiting the index' do
    visit admin_questions_url
    assert_selector 'h1', text: 'Questions'
  end

  test 'creating a Question' do
    visit admin_questions_url
    click_on 'New Question'

    fill_in 'question[text_en]', with: 'test'
    fill_in 'question[text_et]', with: 'test'

    fill_in 'question[answers_attributes][0][text_en]', with: 'test'
    fill_in 'question[answers_attributes][0][text_et]', with: 'test'

    click_on 'Create Question'

    assert_text 'Question was successfully created'
  end

  test 'updating a Question' do
    visit admin_questions_url
    click_on 'Edit', match: :first

    fill_in 'Text en', with: 'new text en'
    click_on 'Update Question'

    assert_text 'Question was successfully updated'
  end

  def test_activation
    question = questions(:one)
    assert question.inactive?

    visit admin_question_path(question)

    click_on 'Activate'
    question.reload

    assert question.active?
    assert_text 'Question has been activated'
    assert_current_path admin_question_path(question)
  end

  def test_deactivation
    question = questions(:one)
    question.activate

    visit admin_question_path(question)

    click_on 'Deactivate'
    question.reload

    assert question.inactive?
    assert_text 'Question has been deactivated'
    assert_current_path admin_question_path(question)
  end
end
