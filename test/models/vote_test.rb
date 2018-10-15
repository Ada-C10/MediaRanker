require "test_helper"

describe Vote do

  describe "Validate" do

    it "only allow one vote per work for a user" do
      user = users(:one)
      work = works(:ben)

      expect(work.votes.count).must_equal 0
      work.upvote(user)
      work.upvote(user)

      expect(work.votes.count).must_equal 1
    end
  end
end
