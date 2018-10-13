class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work, counter_cache: true
  #vote can only be created on the same work by the same user once aka   #each user can only upvote a work once
  validates :user_id, uniqueness: {scope: :work_id, message:"You can only vote once"}
  #validates :user_id, uniqueness: true <- this is what i had before just leave as reference





  #user must be logged in to vote


end
