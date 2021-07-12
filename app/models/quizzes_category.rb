class QuizzesCategory < ApplicationRecord
  belongs_to :category
	belongs_to :quiz
end
