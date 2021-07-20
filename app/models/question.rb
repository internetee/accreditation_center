class Question < ApplicationRecord
  belongs_to :category
  has_many :answers

  has_many :answer_questions, dependent: :destroy

  validates :title, presence: true
end
