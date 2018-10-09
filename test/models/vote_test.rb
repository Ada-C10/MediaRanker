require 'pry'
require 'test_helper'

describe Vote do
  describe 'Validations' do
    let(:vote) { Vote.new }

    it 'must be invalid when fields are left blank' do
      value(vote.valid?).must_equal false
    end

    it 'will not create a vote without a user' do
      work = works(:album)
      vote.work_id = work.id
      vote.save

      expect(vote.errors.messages).must_include :user
    end

    it 'allows user to create a vote' do
      vote1 = votes(:vote1)

      value(vote1.valid?).must_equal true
    end

    it 'will not allow a user to create a vote for the same work twice' do
      vote2 = votes(:vote2)

      user = users(:user2)
      work = works(:album)

      dup_vote = Vote.create(user_id: user.id, work_id: work.id)

      value(vote2.valid?).must_equal true
      value(dup_vote.valid?).must_equal false
      expect(dup_vote.errors.messages).must_include :work_id
    end

    it 'will allow multiple users to vote on the same work' do
      user3 = users(:user3)
      user2 = users(:user2)

      work = works(:book)

      first_vote = Vote.create(user_id: user3.id, work_id: work.id)
      second_vote = Vote.create(user_id: user2.id, work_id: work.id)

      expect(work.votes.length).must_be :>=, 1
    end
  end

  describe 'Relationships' do
    it 'belongs to a work' do
      vote1 = votes(:vote1)

      work = vote1.work

      expect(work).must_be_instance_of Work
      expect(work.id).must_equal vote1.work.id
    end

    it 'belongs to a user' do
      vote2 = votes(:vote2)

      user = vote2.user

      expect(user).must_be_instance_of User
      expect(user.id).must_equal vote2.user.id
    end

  end
end
