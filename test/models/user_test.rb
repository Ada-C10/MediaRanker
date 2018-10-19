require "test_helper"

describe User do
  describe "validations" do

    it "can be created with all attributes" do
      user = User.new(username: "TestUser")

      result = user.valid?

      result.must_equal true
    end

    it "is invalid without a username" do
      user = User.new

      result = user.valid?

      result.must_equal false
    end

    it "is invalid with a duplicate username" do
      dup_name = "duplicate"

      user1 = User.create!(username: dup_name)
      user2 = User.new(username: dup_name)

      result = user2.valid?

      result.must_equal false
    end

  end

  describe "relations" do

    it "connects collection of votes" do
      work = Work.first
      test_user = User.create!( username: "test_username" )
      vote = Vote.create!( user: test_user, work: work )

      test_user.votes.must_include vote
    end

  end

end
