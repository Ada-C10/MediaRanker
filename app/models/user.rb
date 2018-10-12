class User < ApplicationRecord
  has_many :votes
  has_many :works
  has_many :liked_posts, through: :votes
  validates :username, presence: true, uniqueness: true
end
