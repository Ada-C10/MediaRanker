require "test_helper"
require 'pry'

describe Vote do

  before do
    @vote = votes(:vote1)
    @vote1 = votes(:vote2)
    # binding.pry
  end

  it "must be valid when a vote is made" do
    is_valid = @vote.valid?
    expect( is_valid ).must_equal true
  end

  it "must not be valid when a vote is made for the same work by the same user" do


  # vote = Vote.new(work_id: work.id, user_id: @logged_in_user.id)

    repeat_vote = Vote.new(user_id: @vote.user.id, work_id: @vote.work.id)
    # binding.pry
    is_valid = repeat_vote.valid?
    expect( is_valid ).must_equal false

  end

end
