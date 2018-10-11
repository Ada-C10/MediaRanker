require "test_helper"

describe Vote do
  let(:vote) { votes(:one) }
  let(:park) { works(:park) }
  let(:kings) { works(:kings) }
  let(:laura) { users(:laura) }

  describe "Validations" do
    it "won't be valid without user_id or work_id" do
      vote = Vote.new
      expect(vote).wont_be :valid?
    end

    it "will be valid given a user_id and work_id" do
      expect(vote).must_be :valid?
    end

    it "must have a user_id" do
      vote.user_id = nil

      valid = vote.valid?

      expect(valid).must_equal false
      expect(vote.errors.messages).must_include :user
    end

    it "must have a work_id" do
      vote.work_id = nil

      valid = vote.valid?

      expect(valid).must_equal false
      expect(vote.errors.messages).must_include :work
    end

    it "must have a date" do
      vote.date = nil

      valid = vote.valid?

      expect(valid).must_equal false
      expect(vote.errors.messages).must_include :date
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
    describe "vote_allowed" do
      it "returns true if a user has never voted on a specific work" do
        record = Vote.vote_allowed?(laura, park)
        expect(record).must_equal true
      end

      it "returns false if a user has already voted on a specific work" do
        record = Vote.vote_allowed?(laura, kings)
        expect(record).must_equal false
      end
    end

    describe "destroy_votes" do
      it "will destroy all votes that match a work_id" do
        work.destroy_votes
        expect(work.votes.count).must_equal 0
      end
    end
  end
end
