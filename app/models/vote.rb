class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  def upvote
    vote = Vote.new(work_id: @work.id, user_id: @logged_in_user.id)
    # .votes has to be called on an instance, not on the class
  end

end
