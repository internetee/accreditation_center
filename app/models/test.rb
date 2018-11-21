class Test < ApplicationRecord
  belongs_to :user
  has_many :answered_questions
end
