
require "test_helper"

describe Vote do

  before do
    @work = Work.first
    @user = User.find_by(username: "monsiscool")
    @user2 = User.find_by(username: "awesomeguy")
  end

  describe "validations" do


    it "can be created with all attributes" do
      vote = Vote.new( work: @work, user: @user )

      result = vote.valid?

      result.must_equal true

    end

    it "is invalid without a user" do
      vote = Vote.new( work_id: @work.id )

      result = vote.valid?

      result.must_equal false
    end

    it "is invalid without a work" do
      vote = Vote.new( user_id: @user.id )

      result = vote.valid?

      result.must_equal false

    end

    it "is invalid with duplicate work/user combination" do
      vote1 = Vote.create!( user_id: @user.id, work_id: @work.id)
      vote2 = Vote.new( user_id: @user.id, work_id: @work.id )

      result = vote2.valid?
      puts vote2.work_id
      puts vote1.work_id

      result.must_equal false

    end

    it "can belong to same work with different users" do
      vote1 = Vote.create!( user: @user, work: @work )
      vote2 = Vote.new( user: @user2, work: @work )

      result = vote2.valid?

      result.must_equal true

    end


  end

  describe "relations" do

    it "connects user and user_id" do
      vote = Vote.create!( user: @user, work: @work )

      vote.user.id.must_equal @user.id
    end

    it "connects work and work_id" do
      vote = Vote.create!( user: @user, work: @work )

      vote.work.id.must_equal @work.id
    end

  end
end
