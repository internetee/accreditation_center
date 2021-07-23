class Question < ApplicationRecord
  belongs_to :category
  has_many :answers

  has_many :answer_questions, dependent: :destroy

  validates :title, presence: true

  enum question_type: { "single choice": 0, "multiple choice": 1, "long answer": 2 }

  def answered?(current_user)
    return false if current_user.user_answers.last.nil?

    user_answers = current_user.user_answers.last
    user_answers.answer_questions.find_by(question_id: id)
  end

  def answered_was_correct?(current_user)
    return false if current_user.user_answers.last.nil?
  
    user_answers = current_user.user_answers.last
    answer_question = user_answers.answer_questions.find_by(question_id: id)

    return false if answer_question.nil?
    
    answer = Answer.find(answer_question.answer_id)

    answer.correct_answer?
  end
end