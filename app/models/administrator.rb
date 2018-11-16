class Administrator < ApplicationRecord
  devise :database_authenticatable, :validatable, :recoverable, :trackable, :lockable
end
