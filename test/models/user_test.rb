require "test_helper"

describe User do
  let(:user) { users(:two) }

  it "must be valid" do
    expect(user).must_be :valid?
  end

  describe "validations" do
    describe "relationships" do
      it "has relationship to votes" do
        user = users(:one)

        result = user.votes.first

        expect(result).must_be_kind_of Vote

      end

      it "can have one vote per work" do
        user = users(:two)
        work = works(:work1)
        vote = Vote.create(work: work, user: user)

        result = vote.valid?
        expect(result).wont_equal true
      end
    end

    it "won't be valid without username" do
      user = users(:one)
      user.username = nil

      result = user.valid?

      expect(result).wont_equal true
    end

    it "will be valid with a username" do
      result = user.valid?
      expect(result).must_equal true
    end

    it "won't be valid without unique username" do
      new_user = User.new(username: "griffiam")

      result = new_user.valid?

      expect(result).wont_equal true
    end

    it "will be valid with unique username" do
      newest_user = User.new(username: "guru")

      new_result = newest_user.valid?

      expect(new_result).must_equal true
    end
  end


end
