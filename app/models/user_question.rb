class UserQuestion < ApplicationRecord
  belongs_to :category
  belongs_to :question
  belongs_to :quiz
  belongs_to :user
end
