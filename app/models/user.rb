class User < ApplicationRecord
  has_many :votes

  validates :username, presence: true, uniqueness: true

  def get_num_votes
    return self.votes.count
  end

  def get_joindate
    return self.created_at.strftime('%h %d, %Y')
  end
end
