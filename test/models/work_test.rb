require 'test_helper'


describe Work do

  describe 'relations' do

    # note to self: .where returns a collection whereas find_by returns a single record
    it 'each work can have many votes' do
      votes = Vote.where(work_id: "sound_of_music")
      expect(votes.count).must_equal 2
    end
  end

  describe 'validations' do

    before do
      @work = Work.new(title: 'casper babypants', category: 'album')
    end

    # note to self: .valid? checks against yaml file
    it 'is valid when title is unique and category are present' do
      is_valid = @work.valid?
      expect(is_valid).must_equal true
    end

    it 'is invalid if the title is not unique' do
      new_work = Work.new(title: "sound of music", category: "movie")
      is_valid = new_work.valid?
      expect(is_valid).must_equal false
    end

    it 'is not valid without a title' do
      @work.title = nil
      is_valid = @work.valid?
      expect(is_valid).must_equal false
    end

    it 'is not valid without a category' do
      @work.category = nil
      is_valid = @work.valid?
      expect(is_valid).must_equal false
    end
  end

  describe 'custom_methods' do

    # note to self: .new does not save the object that is made versus create! will save the object that is created.
    before do
      @user1 = User.create!(username: "junie")
      @user2 = User.create!(username: "penelope")
      @work = Work.create!(title: "Storks", category: "book")
      @vote1 = Vote.create!(user_id: @user1.id, work_id: @work.id)
      vote2 = Vote.create!(user_id: @user2.id, work_id: @work.id)
    end

    it 'returns the total number of votes for a work' do
      total_votes = @work.total_votes
      expect(total_votes).must_equal 2
    end

    it 'returns an array of users that voted on the work' do
      users_that_upvoted = @work.users_that_voted_on_this_work
      first_user = users_that_upvoted.first.username
      expect(first_user).must_equal "junie"
    end

    it 'returns the vote that connects a user to an upvoted work' do
      vote_id = @vote1.id
      vote = @work.find_vote_where_work_upvoted_by_user(@user1.id)
      id_for_vote = vote.id
      expect(id_for_vote).must_equal vote_id
    end

  end
end
