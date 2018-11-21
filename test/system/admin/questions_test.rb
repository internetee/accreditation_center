require 'application_system_test_case'

class Admin::QuestionsTest < ApplicationSystemTestCase
  setup do
    sign_in administrators(:one)
    @admin_question = questions(:one)
  end

  test "visiting the index" do
    visit admin_questions_url
    assert_selector "h1", text: "Questions"
  end

  test "creating a Question" do
    visit admin_questions_url
    click_on "New Question"

    fill_in "question[text_en]", with: 'test'
    fill_in "question[text_et]", with: 'test'

    fill_in "question[answers_attributes][0][text_en]", with: 'test'
    fill_in "question[answers_attributes][0][text_et]", with: 'test'

    click_on "Create Question"

    assert_text "Question was successfully created"
  end

  test "updating a Question" do
    visit admin_questions_url
    click_on "Edit", match: :first

    fill_in "Text en", with: 'new text en'
    click_on "Update Question"

    assert_text "Question was successfully updated"
  end
end
