class Answer < ApplicationRecord
	belongs_to :question, optional: true
	belongs_to :user_answer, optional: true

	has_many :answer_questions, dependent: :destroy

  validates :title_en, :title_ee, presence: true

	def correct_answer?
		correct
	end

	def custom_label_method
		"<span>#{self.title_ee}</span><br />".html_safe
	end
end
