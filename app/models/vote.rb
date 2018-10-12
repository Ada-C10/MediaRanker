class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  #user must be logged in to vote
  #each user can only upvote a work once 

end
