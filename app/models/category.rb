class Category < ApplicationRecord
  has_many :questions
	has_many :quizzes_categories
	has_many :quizzes, through: :quizzes_categories

  validates :name, presence: true
end
