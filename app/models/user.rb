class User < ApplicationRecord
  has_many :works
  has_many :votes
  has_many :works, through: :votes
end
