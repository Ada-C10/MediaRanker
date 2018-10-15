class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  def upvote(user)
    #Vote.create(user: user, work: self)
    votes.create(user: user)
  end
end
