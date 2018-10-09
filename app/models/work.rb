class Work < ApplicationRecord
  # Many votes can be associated with a single work
  has_many :votes
  # Can do work.votes for an array of all votes associated with the work
  # Can push votes via work.votes << vote_object
  # work.votes.where(conditions) to get votes for the work with the condition 
end
