class Vote < ApplicationRecord
  # A vote belongs to a single user, a single work
  belongs_to :user
  # Gives the option to do vote.user to get the user associated with the vote
  belongs_to :work, :counter_cache => true
  # Gives the option to do vote.work to get the work associated with the vote
  # Validate user is not voting twice
    # validates :work_id, uniqueness: { scope: :user_id, message: "You can only vote once for this work" }

  # Method to check if vote can be made
  # Check user id to see if they've already voted

  # works/4/upvote? Custom route
end
