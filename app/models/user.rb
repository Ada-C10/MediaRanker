class User < ApplicationRecord
  has_many :votes
	has_many :works, through: :votes
	# has_many :works # optional

  validates :username, presence: true
  validates :joined, presence: true

  def vote_date(work)
    return self.votes.find_by(work_id: work.id).date
  end
end
