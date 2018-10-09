class User < ApplicationRecord
  has_many :votes
  has_many :works, through: :votes

  # Did not validate uniqueness since user will be logged in automatically
  validates :name, presence: true
end
