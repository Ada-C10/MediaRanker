require "test_helper"

describe Vote do
  let(:vote) { votes(:one) }
  let(:park) { works(:park) }
  let(:laura) { users(:laura) }

  describe "Validations" do
    it "won't be valid without user_id or work_id" do
      vote = Vote.new
      expect(vote).wont_be :valid?
    end

    it "will be valid given a user_id and work_id" do
      expect(vote).must_be :valid?
    end
  end

  describe "Relationships" do
    it "belongs to a user" do
      expect(vote.user).must_equal users(:alice)
    end

    it "can set the user through .user" do
      vote.user = laura
      expect(vote.user_id).must_equal laura.id
    end

    it "can set the user through .user_id" do
      vote.user_id = laura.id
      expect(vote.user).must_equal laura
    end

    it "belongs to a work" do
      expect(vote.work).must_equal works(:kings)
    end

    it "can set the work through .work" do
      vote.work = park
      expect(vote.work_id).must_equal park.id
    end

    it "can set the work through .work_id" do
      vote.work_id = park.id
      expect(vote.work).must_equal park
    end
  end

  describe "Custom Methods" do
  end
end
