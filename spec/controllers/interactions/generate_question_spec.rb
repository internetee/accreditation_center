require 'rails_helper'
require_relative "../../support/devise"

RSpec.describe GenerateQuestion do
	login_user

	let(:category) { build(:category) }
	let(:question) { build(:question, category: category) }
	let(:quiz) { build(:quiz) }

	it "should generate questions for user" do
		expect(@user.user_questions.count).to eq(0)

		category.save
		question.save
		quiz.save

		GenerateQuestion.process(@user)

		expect(@user.user_questions.count).to eq(20)
	end
end