require "test_helper"
#TODO: refacto with fixtures
describe Vote do
  let (:vote) do
    Vote.create!(user_id: users(:stevonnie).id, work_id: works(:parable).id)
  end

  describe 'Vote validations' do
    it 'is valid when all fields are present' do
      expect(vote.valid?).must_equal true
    end

    it 'has unique user_id within scope work' do
      # Expect valid when the user is a duplicate that's NOT within the scope work
      valid_vote = Vote.new(user_id: users(:stevonnie).id, work_id: works(:valid_nil).id)
      expect(valid_vote.valid?).must_equal true

      # Expect invalid if user is a duplicate within the scope work
      vote.save!
      non_unique_vote = Vote.new(user_id: users(:stevonnie).id, work_id: works(:parable).id)
      expect(non_unique_vote.valid?).must_equal false
    end
  end

  describe 'Vote relations' do
    # belongs_to triggers validation error by default
    it 'is invalid when user_id or work_id are not present' do
      vote.user_id = nil
      expect(vote.valid?).must_equal false
      expect(vote.errors.messages).must_include :user

      vote.work_id = nil
      expect(vote.valid?).must_equal false
      expect(vote.errors.messages).must_include :work
    end

    it 'can get work with \'work\'' do
      expect(vote.work).must_equal Work.find(works(:parable).id)
    end

    it 'can get user with \'user\'' do
      expect(vote.user).must_equal User.find(users(:stevonnie).id)
    end

    it 'deleting a work deletes the associated vote(s)' do
      vote.save!
      parable = works(:parable)
      second_vote = Vote.create!(user_id: users(:pink).id, work_id: parable.id)
      expect(parable.votes).must_equal [vote, second_vote]
      expect(parable.votes.find_by(user_id: users(:stevonnie).id)).must_equal vote
      expect(parable.votes.find_by(user_id: users(:pink).id)).must_equal second_vote

      parable.destroy!

      expect(users(:pink).votes).must_equal []
      expect(users(:stevonnie).votes).must_equal []
    end

  end
end
