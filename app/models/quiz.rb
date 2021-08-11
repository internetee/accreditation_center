class Quiz < ApplicationRecord
	has_many :categories
	has_many :answer_questions, dependent: :destroy
  has_many :user_questions

	belongs_to :user

  validates :title, presence: true
end
