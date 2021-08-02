require 'rails_helper'
require_relative "../support/devise"

RSpec.describe AnswerQuestionsController, type: :controller do
  let(:quiz) { create(:quiz) }
	let(:category) { create(:category) }
	let(:question) { create(:question, category: category) }
  let(:answer) { create(:answer, title_ee: "Title", title_en: "Title") }
  let(:answer_t) { create(:answer, title_ee: "Title", title_en: "Title") }
	let(:user_answer) { build(:user_answer) }
	let(:answer_question) { build(:answer_question, user_answer: user_answer, question: question, answer: answer) }
	let(:answer_question_t) { build(:answer_question) }

	login_user

	context 'actions' do
		it 'post create action' do
			post :create, params: { answer_question: {quiz_id: quiz.id, answer_id: answer.id , question_id: question.id } }

     	expect(response.content_type).to eq "text/html; charset=utf-8"
			expect(response).to have_http_status(:redirect)
		end
	end

	context 'interactions' do
		it 'generate results return false' do
			answer.correct = false
			answer.save
			question.save

			user_answer.save
			answer_question.save

			a = user_answer.answer_questions.last
			p a.answer.correct?

			result = GenerateResult.process(user_answer: user_answer, category_id: question.category_id)

			p result
		end

		it 'generate answer' do
			question.update(question_type: 1)
			answer_question_params = {}

			user_answer.save

			answer_question_params[:answer_id] = [answer.id , answer_t.id]
			answer_question_params[:quiz_id] = quiz.id
			answer_question_params[:question_id] = question.id

			user_answer.answer_questions.empty?

			id = GenerateAnswer.process(answer_question_params, user_answer)
			expect(user_answer.answer_questions.count).to eq(2)
		end

		it 'multiple answers' do
			question.update(question_type: 1)
			answer_question_params = {}

			user_answer.save

			answer_question_params[:answer_id] = [answer.id , answer_t.id]
			answer_question_params[:quiz_id] = quiz.id
			answer_question_params[:question_id] = question.id

			user_answer.answer_questions.empty?

			MultipleAnswerCreate.create_multiple_answer(answer_question_params: answer_question_params,
																															user_answer: user_answer)

			expect(user_answer.answer_questions.count).to eq(2)
		end
	end
end