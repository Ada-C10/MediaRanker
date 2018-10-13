class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
  validates :category, :title, :creator, :published_year, :description, presence: true
  validates :title, uniqueness: true

  def upvote(user)
    if Vote.find_by(user_id: user.id, work_id: self.id)
      return false #vote was created
    else
      vote = Vote.new(user: user, work: self)
      return vote.save
    end
  end
end


# controllers

#@work.upvote(@current_user)
