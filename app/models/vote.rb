class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  def self.votes_by_work(work_id)
    return votes = Vote.where(work_id: work_id)
  end

  def self.already_voted?(work_id, user_id)
    vote = Vote.where(work_id: work_id, user_id: user_id)

    return vote.any?
  end
end
