require "test_helper"

describe Vote do
  before do
    @user = User.first
    @work = Work.first
    @vote = Vote.new
    @vote.user_id = @user.id
    @vote.work_id = @work.id
    @vote.save
  end

  describe 'validations' do

  end

  describe 'relations' do
    it 'must relate to a work' do

    end

    it 'belongs to a work' do
      expect(@vote).must_respond_to :work
      work = @vote.work
      expect(work).must_be_instance_of Work
      expect(work.id).must_equal @vote.work_id
    end

    it 'belongs to a user' do
      expect(@vote).must_respond_to :user
      user = @vote.user
      expect(user).must_be_instance_of User
      expect(user.id).must_equal @vote.user_id

    end

  end

  describe 'custom methods' do

  end
end
