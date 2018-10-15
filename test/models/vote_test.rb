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
    vote.errors.messages.must_include :work_id
    vote.errors.messages.must_include :user
    end

    it "is invalid if both work_id and user_id are present in other Vote instance" do

      vote = votes(:four)
      vote2 = votes(:five)

      vote2.work = vote.work

      vote2.valid?.must_equal false
      vote2.errors.messages.must_include :work_id
    end

    it "is valid if user is not unique" do
      vote4 = votes(:four)
      vote5 = votes(:five)

    vote4.valid?.must_equal true
    vote5.valid?.must_equal true
    end

    it "is valid if work is not unique" do
      vote2 = votes(:two)
      vote4 = votes(:four)

    vote2.valid?.must_equal true
    vote4.valid?.must_equal true
    end
  end
end
