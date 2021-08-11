class Category < ApplicationRecord
	has_many :questions
	has_many :answers
	has_many :results
  has_many :user_questions

	belongs_to :quiz, optional: true

  validates :title, presence: true

	def has_results?
		results.present?
	end
end
