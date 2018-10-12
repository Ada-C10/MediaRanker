require "test_helper"

describe Vote do
  let(:vote) { Vote.new }

  it "must be valid" do # QUESTION: should i have kept these in works and users tests???
    skip
    value(vote).must_be :valid?
  end
end
