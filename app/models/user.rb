class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:username]

  has_many :quizzes
  has_many :user_answers
  has_many :results
  has_many :user_questions

  validates :email, presence: false

  attr_writer :login

  def user_categories(quiz_id)
    quizzes.find(quiz_id).categories
  end

  # def user_results
  #   resutls.count
  # end

  def email_required?
    false
  end

  def password_required?
    false
  end

  def login
    @login || self.username || self.email
  end
end
