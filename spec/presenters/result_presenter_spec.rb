require 'rails_helper'

RSpec.describe ResultPresenter do
	let(:user_answer) { build(:user_answer) }
  let(:quiz) { build(:quiz) }
	let(:question) { build(:question) }
	let(:answer) { build(:answer) }
	let(:answer_question) { build(:answer_question, quiz: quiz) }
	let(:user) { build(:user) }
	let(:result) { build(:result, quiz: quiz) }

	before(:each) do
		user_answer.user = user
		user_answer.answer_questions << answer_question
		user_answer.save

		answer_question.question = question
		answer_question.answer = answer
		answer_question.save

		question.save
		answer.save

		result.save
		@result = ResultPresenter.new(result)
	end

	context "user answer questions" do
		it "should return single answer" do
			answer.title_en = "This is answer"
			answer.save

			expect(@result.user_answer_questions(user_answer: user_answer, question: question)).to eq("<li>This is answer</li>")
		end
	end

	context "answers result" do
		it "should return correct answer" do
			answer.title_en = "This is answer"
			answer.correct = true
			answer.save
			
			expect(@result.answer_result(user_answer: user_answer, question: question)).to eq("<span class=\"green\">Corrent</span>")
		end

		it "should return inctorrect answer" do
			answer.title_en = "This is answer"
			answer.correct = false
			answer.save
			
			expect(@result.answer_result(user_answer: user_answer, question: question)).to eq("<span class=\"answered\">Failed</span>")
		end
	end
end