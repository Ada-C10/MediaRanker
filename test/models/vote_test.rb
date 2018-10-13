require "test_helper"

describe Vote do

  # before do
  #   @work1 = works(:blue)
  #   @work2 = works(:joe)
  #   @work3 = works(:green)
  #
  #   @user1 = users(:house)
  #   @user2 = users(:jones)
  #   @user3 = users(:ada)
# end

# vote = Vote.new(work_id: work.id, user_id: @logged_in_user.id)


it "must be valid when a vote is made" do
  # @vote = Vote.new(work_id: @work1.id, user_id: @user1.id)
  @vote = votes(:vote1)

  is_valid = @vote.valid?
  expect( is_valid ).must_equal true
end



# it "must not be valid when it is made by the same user for the same work" do
#
#   @vote = Vote.new(work_id: @work1.id, user_id: @user1.id)
#   @vote1 = @vote = Vote.new(work_id: @work1.id, user_id: @user1.id)
#
#   is_valid = @vote1.valid?
#   expect( is_valid ).must_equal false
# end









end
