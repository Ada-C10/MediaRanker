require "test_helper"
#TODO: refactor with fixtures
describe Vote do
  let(:vote){ votes(:pvote1) }
  let(:parable){ works(:parable) }
  let(:stevonnie){ users(:stevonnie) }

  describe 'Vote validations' do
    it 'vote fixtures demonstrate which fields are required' do
    # votes are valid when all required fields are present
      Vote.all.each { |vote| expect(vote.valid?).must_equal true }
    end

    it 'has unique user_id within scope work' do
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

    it 'can get work with \'vote.work\'' do
      expect(vote.work).must_equal Work.find_by(title: parable.title)
    end

    it 'can get user with \'vote.user\'' do
      expect(vote.user).must_equal User.find_by(name: stevonnie.name)
    end

    it 'deleting a work deletes the associated vote(s)' do
      expect {
        parable.destroy!
      }.must_change 'stevonnie.votes.count', -1
    end

  end
end
