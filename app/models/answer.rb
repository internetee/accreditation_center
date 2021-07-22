class Answer < ApplicationRecord
	belongs_to :question
	# belongs_to :user_answer

	has_many :answer_questions, dependent: :destroy

  validates :title_en, :title_ee, presence: true
end
