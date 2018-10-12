require "test_helper"

describe Vote do
  let(:vote) { Vote.new }
  let(:user) { User.new(username: 'Amanda')}
  it "must be valid" do
    value(vote).must_be :valid?
  end
end
