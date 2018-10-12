require "test_helper"

describe Vote do
  describe 'Vote validations' do
    before do
      @user = User.create!(name: 'test name')
      @work = Work.create!(title: 'test book', category: :album,
        creator: 'test creator', publication: 2018,
        description: 'test description')
      @vote = Vote.new(user_id: @user.id, work_id: @work.id)
    end

    it 'is valid when all fields are present' do
      expect(@vote.valid?).must_equal true
    end

    it 'has unique user_id within scope work' do
      @vote.save
      expect(@vote.valid?).must_equal true
      another_vote = Vote.new(user_id: @user.id, work_id: @work.id)
      expect(another_vote.valid?).must_equal false
      expect(@vote.user_id).must_equal another_vote.user_id
      expect(@vote.work_id).must_equal another_vote.work_id
    end
  end

  describe 'Vote relations' do
    before do
      @user = User.create!(name: 'test name')
      @work = Work.create!(title: 'test book', category: :album,
        creator: 'test creator', publication: 2018,
        description: 'test description')
      @vote = Vote.new(user_id: @user.id, work_id: @work.id)
    end

    # belongs_to triggers validation error by default
    it 'is invalid when user_id or work_id are not present' do
      @vote.user_id = nil
      expect(@vote.valid?).must_equal false
      expect(@vote.errors.messages).must_include :user

      @vote.work_id = nil
      expect(@vote.valid?).must_equal false
      expect(@vote.errors.messages).must_include :work
    end

    it 'can get work with \'work\'' do
      expect(@vote.work).must_equal Work.find(@work.id)
    end

    it 'can get user with \'user\'' do
      expect(@vote.user).must_equal User.find(@user.id)
    end

# TODO: prune this down
    it 'deleting a work deletes the associated vote(s)' do
      @vote.save
      @second_user = User.create!(name: 'user two')
      @second_vote = Vote.create(user_id: @second_user.id, work_id: @work.id)
      expect(@work.votes[1].user_id).must_equal @second_user.id
      expect(@work.votes.length).must_equal 2
      expect(@work.votes.find_by(user_id: @user.id)).must_equal @vote
      expect(@work.votes.find_by(user_id: @second_user.id)).must_equal @second_vote
      @work.destroy!
      expect(@work.votes.length).must_equal 0
      expect(@work.votes.find_by(user_id: @second_user.id || @user.id)).must_equal nil
    end

  end
end
