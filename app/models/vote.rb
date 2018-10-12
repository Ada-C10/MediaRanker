class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
  #i need to put in a validation to make sure a
  #vote can only be created on the same work by the same user once
  #validates :user_id, uniqueness: true
  validates :user_id, uniqueness: {scope: :work_id, message:"You can only vote once"}

  #user must be logged in to vote
  #each user can only upvote a work once

end
