class Question < ApplicationRecord
  belongs_to :category
  has_many :answers

  validates :text_en, :text_et, presence: true

  accepts_nested_attributes_for :answers, allow_destroy: true

  def to_s
    text_en
  end
end
