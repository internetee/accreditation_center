class Administrator < ApplicationRecord
  devise :database_authenticatable, :validatable, :recoverable, :trackable, :lockable

  def to_s
    email
  end
end
