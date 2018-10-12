class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user
  # belongs_to triggers validation error by default
  # is invalid when user_id or work_id are not present
  # expect(@vote.work).must_equal Work.find(@work.id)
  # expect(@vote.user).must_equal User.find(@user.id)

  validates :user_id, uniqueness: { scope: :work,
     message: "should only be one user_id per work" }

end
