class Vote < ApplicationRecord
  # A vote belongs to a single user, a single work
  belongs_to :user
  # Gives the option to do vote.user to get the user associated with the vote
  belongs_to :work, counter_cache: true 

  # I think this prevents voting more than once
  # https://www.reddit.com/r/rails/comments/2su4ib/please_share_any_resources_related_to_modifying/
  validates :user, uniqueness: { scope: :work, message: "You can only vote once for this work" }
  validates :work, uniqueness: { scope: :user, message: "You can only vote once for this work" }

end
