class User < ApplicationRecord
  has_many :votes
  has_many :works, through: :votes

  validates :username, uniqueness: true, presence: true
  validates :username, length: { minimum: 5 }
end
