class Test < ApplicationRecord
  belongs_to :user
  has_many :answered_questions, dependent: :destroy

  class << self
    def clean_old_tests
      old_tests.each do |test|
        test.answered_questions.delete_all
        yield test
      end
    end

    private

    def old_tests
      days_before_cleaning = Rails.configuration.tests.days_before_cleaning
      where(%{("end" + interval '?' day) < ?}, days_before_cleaning, Time.zone.now)
    end
  end
end
