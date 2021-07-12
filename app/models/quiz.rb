class Quiz < ApplicationRecord
	has_many :quizzes_categories
	has_many :categories, through: :quizzes_categories
end
