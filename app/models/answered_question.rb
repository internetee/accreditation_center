class AnsweredQuestion < ApplicationRecord
  belongs_to :test
  belongs_to :question
  belongs_to :answer
end
