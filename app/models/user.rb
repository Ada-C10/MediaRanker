class User < ApplicationRecord
  # has_many :works, through: :votes
  validates :username, presence: true, uniqueness: true
  has_many :votes
end
