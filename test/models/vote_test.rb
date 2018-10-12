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

  it "must not allow two votes by one user for a single work" do
    vote2.user = users(:two)
    vote2.work = works(:ten)
    expect(vote2.valid?).must_equal false
    expect(vote2.errors.messages).must_include :work_id
  end

  it "must be able to have two different users vote for the same work" do
    vote2.work = works(:ten)
    expect(vote2.valid?).must_equal true
  end


end
