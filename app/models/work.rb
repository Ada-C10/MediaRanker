class Work < ApplicationRecord
  # Many votes can be associated with a single work
  has_many :votes
  validates :work_id, uniqueness: { scope: :user_id, message: "You can only vote once for this work" }

  validates :category, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true
  validates :title, presence: true, uniqueness: true

  # Can do work.votes for an array of all votes associated with the work
  # Can push votes via work.votes << vote_object
  # work.votes.where(conditions) to get votes for the work with the condition
  # Method to upvote a work. Will need to make sure user/work is unique
  # User can only vote once per work

  # Method to sort by category
  # Handle if there are no works
  # If there's no votes (randomly, alphabetically?,)
  # Tie votes

end
