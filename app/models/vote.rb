class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  def self.votes_by_work(work_id)
    return votes = Vote.where(work_id: work_id)
  end

end
