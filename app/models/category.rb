class Category < ApplicationRecord
	has_many :questions
	has_many :answers
	has_many :results
	belongs_to :quiz

  validates :title, presence: true

	def has_results?
		results.present?
	end
end
