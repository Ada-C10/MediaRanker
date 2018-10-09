class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  def vote_allowed?
    record = Vote.all.where(user_id: @current_user.id, work_id: @work.id)

    if record.nil?
      return true
    else
      return false
    end
  end
end
