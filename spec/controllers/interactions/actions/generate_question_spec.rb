require 'rails_helper'
require_relative "../../../support/devise"

RSpec.describe GenerateQuestions do
	login_user

	let(:category) { build(:category) }
	let(:question) { build(:question) }
	let(:quiz) { build(:quiz) }
	let(:template_setting_display) { build(:template_setting_display) }

	it "should generate questions for user" do
		expect(@user.user_questions.count).to eq(0)

		category.save
		question.save
		quiz.save

		GenerateQuestions.process(user: @user, quiz: quiz)

		expect(@user.user_questions.count).to eq(20)
	end

	it "should generate questions for user by template" do
		quiz.save
		category.quiz = quiz
		category.save
		
		question.category = category
		question.save
		category.questions << question
		
		template_setting_display.category = category
		template_setting_display.display = true
		template_setting_display.count = 1
		template_setting_display.save

		GenerateQuestions.process(user: @user, quiz: quiz)

		expect(@user.user_questions.count).to eq(1)
	end
end