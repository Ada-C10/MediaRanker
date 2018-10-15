require "test_helper"

# describe Vote do
#   let(:vote) { Vote.new }
#
#   it "must be valid" do
#     value(vote).must_be :valid?
#   end
# end
describe Vote do
  describe 'relations' do
    before do
      @user = User.first

      @work = Work.first

    end

    it 'can add a work to a vote' do
      vote = Vote.new(user: @user)
      vote.work = @work
      expect(vote.work).must_equal @work
      expect(vote.work).must_be_instance_of Work
    end

    it 'can add a user to a vote' do
      vote = Vote.new(work: @work)
      vote.user = @user
      expect(vote.user).must_equal @user
      expect(vote.user).must_be_instance_of User
    end
  end

  describe Vote do
    before do
      @a_vote = Vote.new(user: User.find_by(user_name: 'Nick'), work: Work.find_by(category: 'movie'))
      @another_vote = votes(:vote_three)
    end

    it 'is invalid if same user votes for same work' do
      @a_vote.user = @another_vote.user
      @a_vote.work = @another_vote.work
      expect(@a_vote.valid?).must_equal false
      expect(@another_vote.valid?).must_equal false
    end

    it 'is is invalid if user id and work id are nil' do
      @a_vote.user_id = nil
      @a_vote.work_id = nil
      expect(@a_vote.valid?).must_equal false
    end

  end
end
