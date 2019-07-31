class User < ApplicationRecord
  # :confirmable, :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
