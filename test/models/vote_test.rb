require "test_helper"

describe Vote do
  describe 'validations' do

    it "is valid with all fields present" do
      vote = votes(:one)
      result = vote.valid?

      expect(result).must_equal true
    end

    it "is invalid if user_id is nil" do
      vote = votes(:two)
      vote.user_id = nil

      result = vote.valid?

      expect(result).must_equal false
      expect(vote.errors.messages).must_include :user
    end

    it "is invalid if work_id is nil" do
      vote = votes(:two)
      vote.work_id = nil

      result = vote.valid?

      expect(result).must_equal false
      expect(vote.errors.messages).must_include :work
    end

    it "is invalid if both work_id and user_id are not present" do
    vote = votes(:two)

    vote.work_id = nil
    vote.user_id = nil

    vote.valid?.must_equal false
    vote.errors.messages.must_include :work
    vote.errors.messages.must_include :user
    end

    # uniqueness

  end
end
