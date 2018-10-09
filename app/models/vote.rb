class Vote < ApplicationRecord
  # A vote belongs to a single user, a single work
  belongs_to :user
  # Gives the option to do vote.user to get the user associated with the vote
  belongs_to :work
  # Gives the option to do vote.work to get the work associated with the vote

  
end
