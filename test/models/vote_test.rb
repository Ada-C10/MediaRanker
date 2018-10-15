require "test_helper"

describe Vote do
  let(:vote) { votes(:user1_book1) }

  it "must belong to a user" do
    user = vote.user
    valid = vote.valid?

    expect(valid).must_equal true
    expect(user).must_equal users(:user1)

    vote.user = nil
    valid = vote.valid?
    expect(valid).must_equal false
    vote.errors.must_include :user

  end

  it "must belong to a work" do
    work = vote.work
    valid = vote.valid?

    expect(valid).must_equal true
    expect(work).must_equal works(:book1)

    vote.work = nil
    valid = vote.valid?
    expect(valid).must_equal false
    vote.errors.must_include :work

  end

  it "must have one user" do
    one_obj = vote.user

    expect(one_obj).must_be_kind_of User
  end

  it "must have one work" do
    one_obj = vote.work

    expect(one_obj).must_be_kind_of Work
  end

  it "must respond to user" do
    expect(vote).must_respond_to :user
  end

  it "must respond to work" do
    expect(vote).must_respond_to :work
  end
end
