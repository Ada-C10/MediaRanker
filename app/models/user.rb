class User < ApplicationRecord
  # Multiple votes can be associated with a single user
  has_many :votes
  # has_many :works :through :votes = Not needed 
  validates :name, presence: true
  validates :name, uniqueness: true

  # Can do user.votes for an array of all votes associated with the user
  # Can push votes via user.votes << vote_object
  # user.votes.where(conditions) to get votes for the user with the condition
end
