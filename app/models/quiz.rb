class Quiz < ApplicationRecord
	has_many :categories
	has_many :answer_questions, dependent: :destroy

  validates :title, presence: true

	# TODO
	# Создать ассоциации с юзером
end
