require "test_helper"

describe Vote do
  let(:vote) { Vote.new(user_id: 1, work_id: 1) }

  it "must be valid" do
    value(vote).must_be :valid?
  end
end
