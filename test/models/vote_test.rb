require "test_helper"

describe Vote do

  before do
    @arbitrary_vote = Vote.new(user: User.find_by(username: "first-name123"), work: Work.find_by(category: 'movie'))
    @valid_unique_vote = votes(:different_one)
    # Vote.first
  end

  describe 'validations' do
    it 'is valid when a valid user and valid vote are present' do

      empty_hash = {}
      expect(@valid_unique_vote.valid?).must_equal true
      expect(@valid_unique_vote).must_be_kind_of Vote
      expect(@valid_unique_vote.errors.messages).must_equal empty_hash
    end

    it 'is is invalid if user and work uninstantiated' do

      @arbitrary_vote.user = nil
      @arbitrary_vote.work = nil

      expect(@arbitrary_vote.valid?).must_equal false
      expect(@arbitrary_vote.errors.messages).must_include :user, :work
    end

    it 'is is invalid if user id and work id are nil' do

      @arbitrary_vote.user_id = nil
      @arbitrary_vote.work_id = nil

      expect(@arbitrary_vote.valid?).must_equal false
      expect(@arbitrary_vote.errors.messages).must_include :user_id, :work_id
    end

    it 'is invalid if same user votes for same work' do

      @arbitrary_vote.user = @valid_unique_vote.user
      @arbitrary_vote.work = @valid_unique_vote.work

      expect(@arbitrary_vote.valid?).must_equal false
      expect(@arbitrary_vote.errors.messages).must_include :work
    end

    it 'is valid if different users vote for same work' do
      same_work_one = votes(:same_work_one)
      same_work_two = votes(:same_work_two)

      expect(same_work_one.work).must_equal same_work_two.work
      expect(same_work_one.user).wont_equal same_work_two.user
      expect(same_work_one.valid?).must_equal true
      expect(same_work_two.valid?).must_equal true
    end
  end

end
