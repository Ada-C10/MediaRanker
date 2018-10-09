require "test_helper"

describe Vote do
  let(:vote) { votes(:marshall_billy) }

  it "must be valid" do
    value(vote).must_be :valid?
  end
end
