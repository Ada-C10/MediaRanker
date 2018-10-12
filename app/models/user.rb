class User < ApplicationRecord
  # has_many :works, through: :votes
  has_many :votes
end
