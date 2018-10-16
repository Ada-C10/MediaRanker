require "test_helper"
#TODO: refactor with fixtures
describe Vote do
  let(:vote){ votes(:pvote1) }
  let(:parable){ works(:parable) }
  let(:stevonnie){ users(:stevonnie) }

  describe 'Vote validations' do
    it 'is valid when all fields are present' do
      expect(Vote.first.valid?).must_equal true # fixtures are loaded in a random order
    end

    it 'has unique user_id within scope work' do
      # Expect valid when the user is a duplicate that's NOT within the scope work
      expect(votes(:pvote1).user).must_equal votes(:dvote1).user
      expect(votes(:dvote1).valid?).must_equal true

      # Expect invalid if user is a duplicate within the scope work
      non_unique_vote = Vote.new(user_id: users(:stevonnie).id, work_id: works(:parable).id)
      expect(non_unique_vote.valid?).must_equal false
    end
  end

  describe 'Vote relations' do
    # belongs_to triggers validation error by default
    it 'is invalid when user_id or work_id are not present' do
      nouser = votes(:pvote1)
      nouser.user_id = nil
      expect(nouser.valid?).must_equal false
      expect(nouser.errors.messages).must_include :user

      nowork = votes(:pvote2)
      nowork.work_id = nil
      expect(nowork.valid?).must_equal false
      expect(nowork.errors.messages).must_include :work
    end

    it 'can get work with \'work\'' do
      expect(vote.work).must_equal Work.find(works(:parable).id)
    end

    it 'can get user with \'user\'' do
      expect(vote.user).must_equal User.find(users(:stevonnie).id)
    end

    it 'deleting a work deletes the associated vote(s)' do
      expect {
        parable.destroy!
      }.must_change 'stevonnie.votes.count', -1
    end

  end
end
