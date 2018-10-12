class User < ApplicationRecord
  validates :name, presence: true
  has_many :votes
  has_many :upvoted_works, through: :votes, source: :work
end
