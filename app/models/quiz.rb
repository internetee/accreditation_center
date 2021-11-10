class Quiz < ApplicationRecord
	has_many :categories
	has_many :answer_questions, dependent: :destroy
  has_many :user_questions

	belongs_to :result, optional: true
	belongs_to :user

  validates :title, presence: true

	def has_result?
		!self.result.blank?
	end
end
