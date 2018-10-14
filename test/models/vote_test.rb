require "test_helper"

#does it upvote?
#does it downvoate?
#does it allow non-user to vote?
#does it allow user to vote twice?


describe Vote do
  let(:vote) { Vote.new }

  it "must be valid" do
    value(vote).must_be :valid?
  end
end
