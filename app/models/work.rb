class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
  validates :title, presence: true

  def upvote(user)
    if Vote.find_by(user_id: user.id, work_id: self.id  )
      return false #vote was created
    else
      vote = Vote.new
      vote.user = user
      vote.work = self
      return vote.save
    end
  end
end


# controllers

#@work.upvote(@current_user)
