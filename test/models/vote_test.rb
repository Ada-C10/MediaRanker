require "test_helper"
require 'pry'

describe Vote do

  before do
    @vote1 = votes(:vote1)
    @vote2 = votes(:vote2)
    # binding.pry
  end

  it "must be valid when a vote is made" do
    is_valid = @vote1.valid?
    expect( is_valid ).must_equal true
  end



  it "must not be valid when a vote is made for the same user for the same work" do

    # vote = Vote.new(work_id: work.id, user_id: @logged_in_user.id)

    repeat_vote = Vote.new(user_id: @vote1.user.id, work_id: @vote1.work.id)
    # binding.pry
    is_valid = repeat_vote.valid?
    expect( is_valid ).must_equal false
  end


  it "allows 2 different users to vote for the same work" do

    # vote = Vote.new(work_id: work.id, user_id: @logged_in_user.id)
    @vote3 = votes(:vote3)


    same_work_vote = Vote.new(user_id: @vote1.user.id, work_id: @vote3.work.id)
    # binding.pry
    is_valid = same_work_vote.valid?
    expect( is_valid ).must_equal true
  end


  #
  # it "allows 2 different users to vote for the same work" do
  #
  #   # vote = Vote.new(work_id: work.id, user_id: @logged_in_user.id)
  #   @vote3 = votes(:vote3)
  #
  #
  #   same_work_vote = Vote.new(user_id: @vote1.user.id, work_id: @vote3.work.id)
  #   # binding.pry
  #   is_valid = same_work_vote.valid?
  #   expect( is_valid ).must_equal true
  # end





end
