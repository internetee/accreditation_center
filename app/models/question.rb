class Question < ApplicationRecord
  belongs_to :category
  has_many :answers, inverse_of: :question

  validates :text_en, :text_et, presence: true

  accepts_nested_attributes_for :answers, allow_destroy: true

  def to_s
    text_en
  end

  def inactive?
    !active?
  end

  def activate
    self.active = true
    save!
  end

  def deactivate
    self.active = false
    save!
  end
end
