class User < ApplicationRecord
  has_many :votes
	has_many :works, through: :votes
	# has_many :works # optional

  validates :username, presence: true
  validates :joined, presence: true

  def vote_date(work)
    vote = self.votes.find_by(work_id: work.id)
    return vote ? vote.date : nil
  end

  def vote_count
    return self.votes.length
  end

  def eligible_to_vote?(work)
    return !(works.include? work) # true if work not already in users votes
  end
end
