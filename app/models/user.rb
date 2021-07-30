class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:username]

  has_many :quizzes
  has_many :user_answers

  validates :email, presence: false

  attr_writer :login

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
