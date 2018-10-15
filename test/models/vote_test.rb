require "test_helper"

describe Vote do
  let(:vote) { votes(:two) }

  it "must be valid" do
    expect(vote).must_be :valid?
  end

  describe "validations" do
    describe "relationships" do
      it "has a relationship with users" do
        vote = votes(:one)

        result = vote.user

        expect(result).must_be_kind_of User
      end

      it "has a relationship with works" do
      end
    end

    describe "one_vote_per_user" do
      it "wont be valid if user votes on work already" do
        work = works(:work1)
        user = users(:two)

        vote = Vote.create(work: work, user: user)

        result = vote.valid?

        expect(result).wont_equal true
      end

      it "will be valid if user hasnt voted on work" do
        work = works(:work3)
        user = users(:one)

        vote = Vote.create(work: work, user: user)

        result = vote.valid?

        expect(result).must_equal true
      end
    end


  end
end
