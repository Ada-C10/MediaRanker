require "test_helper"

describe Vote do
  let(:vote1) { votes(:vote1)}
  let(:vote2) { votes(:vote2)}

  it "must be valid if all params are filled correctly" do
    expect(vote1.valid?).must_equal true
  end

  it "must have a user" do
    vote1.user = nil
    expect(vote1.valid?).must_equal false
    expect(vote1.errors.messages).must_include :user
  end

  it "must have a work" do
    vote2.work = nil
    expect(vote2.valid?).must_equal false
    expect(vote2.errors.messages).must_include :work
  end


end
