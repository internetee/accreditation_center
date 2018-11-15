class Admin < ApplicationRecord
  devise :database_authenticatable, :validatable, :recoverable, :trackable, :lockable
end
