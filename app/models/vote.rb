class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :work_id, presence: true
  #
  # def upvote
  #   vote = Vote.new(work_id: @work.id, user_id: @logged_in_user.id)
  # end

end
