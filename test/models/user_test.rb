require "test_helper"

describe User do
  describe "Relations" do
    let(:user) { User.new }
    let(:danielle) {users(:danielle)}

    it "must be valid" do
      value(user).must_be :valid?
    end

    it "has many votes" do
      danielle.must_respond_to :votes
      expect(danielle.votes.length).must_equal 2
      danielle.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

    it "has many works" do
      danielle.must_respond_to :works
      expect(danielle.works.length).must_equal 2
      danielle.works.each do |work|
        expect(work).must_be_instance_of Work
      end
    end
  end

  describe "Validations" do
  end
end
