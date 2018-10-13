class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true, uniqueness: {
    scope: :category, message: "A category can't have repeat name"
  }

  validates :category, presence: true



  def total_votes
    # Vote.count(work_id: work_id)
    total_votes = Vote.where(work_id: id)
    total_votes = total_votes.length
    return total_votes
  end

#find me all the votes for one particular work_id, and then give me all ther user that are in there
  # def get_users
  #   votes = Vote.where(work_id: id)
  #   users = []
  #   votes.each do |vote|
  #      users << vote.user
  #   end
  #   return users
  # end




end
