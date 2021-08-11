class Question < ApplicationRecord
  belongs_to :category
  has_many :answers
  has_many :user_questions

  has_many :answer_questions, dependent: :destroy

  validates :title, presence: true

  enum question_type: { "single choice": 0, "multiple choice": 1, "long answer": 2 }

  def correct_answers
    answers.where(correct: true)
  end

  def answered?(current_user)
    return false if current_user.user_answers.last.nil?

    user_answers = current_user.user_answers.last

    return true if user_answers.answer_questions.find_by(question_id: id)
  
    false
  end

  def answered_was_correct?(current_user)
    return false if current_user.user_answers.last.nil?
  
    user_answers = current_user.user_answers.last
    answer_question = user_answers.answer_questions.find_by(question_id: id)

    return false if answer_question.nil?
    return false if answer_question.answer_id.nil?
    
    answer = Answer.find(answer_question.answer_id)

    answer.correct_answer?
  end

  def multiple_answers_were_correct?(current_user)
    return false if current_user.user_answers.last.nil?

    user_answers = current_user.user_answers.last
    answer_questions = user_answers.answer_questions.where(question_id: id)
    return false if answer_questions.nil?

    answers_for_this_question = Answer.where(question_id: id)
    correct_answers = answers_for_this_question.select { |answer| answer.correct_answer?} 

    count = 0
    answer_questions.each do |item|
      answer = Answer.find(item.answer_id)
      return false unless answer.correct_answer?
      count += 1
    end
    

    
    correct_answers.count == count
  end
end