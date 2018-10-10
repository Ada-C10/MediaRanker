class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  def self.vote_allowed?(current_user, work)
    record = self.all.where(user_id: current_user.id, work_id: work.id)

    if record.empty?
      return true
    else
      return false
    end
  end
end
