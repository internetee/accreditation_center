class Question < ApplicationRecord
  belongs_to :category
  has_many :answers

  validates :title, presence: true
end
