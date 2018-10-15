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



end
