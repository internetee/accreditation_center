require 'rails_helper'
require_relative "../support/devise"

RSpec.describe AnswerQuestionsController, type: :controller do
  let(:quiz) { create(:quiz) }
	let(:category) { create(:category) }
	let(:question) { create(:question, category: category) }
	let(:question_second) { create(:question, category: category) }
  let(:answer) { create(:answer, title_ee: "Title", title_en: "Title") }
  let(:answer_t) { create(:answer, title_ee: "Title", title_en: "Title") }
	let(:user_answer) { build(:user_answer) }
	let(:answer_question) { build(:answer_question, user_answer: user_answer, question: question, answer: answer) }
	let(:answer_question_t) { build(:answer_question) }

	login_user

  # СДЕЛАТЬ МОКОВЫМИ МЕТОДАМИ, ЧТОНИБУДЬ ВЫБРАТЬ ИЗ СООБЩЕНИЯ ОБ ОШИБКИ:

  # 1) AnswerQuestionsController actions post create action
  # Failure/Error: base_url + endpoint

  # NoMethodError:
  #   undefined method `+' for nil:NilClass
  # # ./app/services/create_domain.rb:11:in `domain_endpoint'
  # # ./app/services/create_domain.rb:19:in `create_domain'
  # ./app/controllers/interactions/actions/generate_transfer_code.rb:9:in `process'
  # ./app/controllers/interactions/cache_initializer.rb:29:in `set_transfer_domain_data'
  # ./app/controllers/interactions/cache_initializer.rb:8:in `generate_values'
  # ./app/controllers/application_controller.rb:22:in `initialize_сache_values'
  # ./spec/controllers/answer_questions_controller_spec.rb:18:in `block (3 levels) in <top (required)>'

  before(:each) do
    answer_question_params = {
      quiz_id: quiz.id,
      question_id: question.id,
      answer_id: answer.id,
    }

    allow(GenerateAnswer).to receive(:process).with(answer_question_params, user_answer).and_return(question.id)
  end

	context 'interactions' do
		it 'generate results return false' do
			answer.correct = false
			answer.save
			question.save

			user_answer.save
			answer_question.save
			quiz.save

			a = user_answer.answer_questions.last

			result = GenerateResult.process(user_answer: user_answer, quiz_id: quiz.id)
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