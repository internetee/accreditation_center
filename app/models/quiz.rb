class Quiz < ApplicationRecord
	has_many :categories
	has_many :answer_questions, dependent: :destroy

	belongs_to :user

  validates :title, presence: true
end
