require "test_helper"

describe Vote do

  describe "relations" do
    let(:vote1) { votes(:voteone) }
    it "must be valid" do
      value(vote1).must_be :valid?
    end
    it "has a work" do
      vote1.must_respond_to :work
      vote1.work.must_be_kind_of Work
    end
    it "has a user" do
      vote1.must_respond_to :user
      vote1.user.must_be_kind_of User
    end
  end

  describe "Validations" do
    let(:pride) { works(:pride) }
    let(:hp) { works(:harrypotter) }
    let(:renee) { users(:renee) }
    let(:austin) { users(:austin) }

    it "allows a user to vote for a work" do
      vote1 = Vote.new(work: pride, user: renee)
      vote1.save
      expect(vote1).must_be :valid?
    end

    it "allows multiple users to vote for a work" do
      vote1 = Vote.new(work: pride, user: renee)
      vote1.save
      vote2 = Vote.new(work: pride, user: austin)
      vote2.save
      expect(vote2).must_be :valid?
    end

    it "allows one user to vote for multiple works" do
      vote1 = Vote.new(work: pride, user: renee)
      vote1.save
      vote2 = Vote.new(work: hp, user: renee)
      vote2.save
      expect(vote2).must_be :valid?
    end

    it "allows user to only vote once for a work" do
      vote1 = Vote.new(work: pride, user: renee)
      vote1.save
      vote2 = Vote.new(work: pride, user: renee)
      valid = vote2.save

      expect(valid).must_equal false
      expect(vote2.errors.messages).must_include :work_id
    end
  end
end
