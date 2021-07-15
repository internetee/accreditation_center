class Category < ApplicationRecord
	has_many :questions
	belongs_to :quiz
end
