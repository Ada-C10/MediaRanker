class User < ApplicationRecord
  has_many :votes
  has_many :liked_posts, through: :votes
end
