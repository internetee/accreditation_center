class Category < ApplicationRecord
	has_many :questions
	belongs_to :quiz

  validates :title, presence: true
end
