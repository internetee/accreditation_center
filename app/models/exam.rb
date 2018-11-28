class Exam < ApplicationRecord
  belongs_to :examinee
  has_many :answered_questions, dependent: :destroy

  class << self
    def clean_old_exams
      old_exams.each do |exam|
        exam.answered_questions.delete_all
        yield exam
      end
    end

    private

    def old_exams
      days_before_cleaning = Rails.configuration.exams.days_before_cleaning
      where(%{("end" + interval '?' day) < ?}, days_before_cleaning, Time.zone.now)
    end
  end

  def results
    results = {}

    answered_questions.each do |answered_question|
      results[answered_question.question] = [] unless results[answered_question.question]
      results[answered_question.question] << answered_question.answer
    end

    results
  end
end
