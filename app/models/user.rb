class User < ApplicationRecord
  has_many :votes

  validates :username, presence: true

  def vote(input_work_id)
    vote = Vote.where(user_id: self.id, work_id: input_work_id)
    return vote
  end
end
