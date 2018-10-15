class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user_id, presence: true
  validates :work_id, presence: true, uniqueness: { scope: :user_id }
  #
  # def upvote
  #   vote = Vote.new(work_id: @work.id, user_id: @logged_in_user.id)
  # end

end
