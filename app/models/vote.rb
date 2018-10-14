class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  # TOTAL_VOTES = 0
  #
  # def self.upvote
  #   TOTAL_VOTES += 1
  # end
end
