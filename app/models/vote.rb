class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

end

#upvote
##edge cases
###one user trying to upvote twice
# 1. test where the user already has a vote for that work
# 2. test where the user does not have a vote for that work
# (the model does not track who has not been logged in)

#works sorted by vote
# .order(votes)
## edge cases
### if there are no works in a category
### if there's no votes in a category
### tie between 2 pieces of work
