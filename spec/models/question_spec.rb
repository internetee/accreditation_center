require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:user) { build(:user) }
  let(:user_answer) { build(:user_answer, user_id: user.id) }
  let(:question) { build(:question, id: 1, title: "Hey") }
  let(:answer) { build(:answer, question_id: question.id) }
  let(:answer_two) { build(:answer, question_id: question.id) }

  let(:answer_question) { build(:answer_question, question_id: question.id, user_answer_id: user_answer.id, answer_id: answer.id) }
  let(:answer_question_two) { build(:answer_question, question_id: question.id, user_answer_id: user_answer.id, answer_id: answer_two.id) }

  context 'check validation' do
    it 'check presence of title field' do
      question.title = nil

      expect(question.save).to be false
    end
  end

  describe 'models methods' do
    it 'question should be answered' do
      user.save
      user_answer.save
      question.save
      answer_question.save

      expect(question.answered?(user)).to be true
    end

    it 'question was not answered' do
      user.save
      user_answer.save
      question.save
      
      expect(question.answered?(user)).to be false
    end

    it 'single answer should be correct' do
      user.save
      user_answer.save
      question.save

      answer.correct = true
      answer.save

      answer_question.save

      expect(question.answered_was_correct?(user)).to be true
    end

    it 'single answer should be invalid' do
      user.save
      user_answer.save
      question.save

      answer.correct = false
      answer.save

      answer_question.save

      expect(question.answered_was_correct?(user)).to be false
    end

    it 'multiple answers should be correct' do
      user.save
      user_answer.save
      question.save

      answer.correct = true
      answer.save

      answer_two.correct = true
      answer_two.save

      answer_question.save
      answer_question_two.save

      expect(question.multiple_answers_were_correct?(user)).to be true
    end

    it 'multiple answers should be invalid' do
      user.save
      user_answer.save
      question.save

      answer.correct = true
      answer.save

      answer_two.correct = false
      answer_two.save

      answer_question.save
      answer_question_two.save

      expect(question.multiple_answers_were_correct?(user)).to be false
    end

    it 'multiple answers should be invalid if one answer correct and second is invalid' do
      user.save
      user_answer.save
      question.save

      answer.correct = true
      answer.save

      answer_two.correct = false
      answer_two.save

      answer_question.save
      answer_question_two.save

      expect(question.multiple_answers_were_correct?(user)).to be false
    end
  end
end
