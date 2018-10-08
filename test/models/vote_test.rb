require 'pry'
require "test_helper"

describe Vote do
  describe 'validations' do
    let(:vote) { Vote.new }

    it "must be invalid when fields are left blank" do
      value(vote.valid?).must_equal false
    end

    it "is valid when required fields are provided" do
      vote1 = votes(:vote1)

      value(vote1.valid?).must_equal true
    end

    it "will not allow a user to create a vote for the same work twice" do
      vote2 = votes(:vote2)
      user = users(:user2)
      work = works(:album)

      dup_vote = Vote.new(user_id: user.id, work_id: work.id)
      dup_vote.save

      value(dup_vote.valid?).must_equal false
      expect(dup_vote.errors.messages).must_include :work_id
    end
  end

  describe 'relationships' do

  end
end
