class User < ApplicationRecord
  has_many :votes, dependent: :delete_all
  has_many :works, through: :votes
  validates :user_name, presence: true, uniqueness: true
end
