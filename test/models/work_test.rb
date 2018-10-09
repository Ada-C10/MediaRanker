require "test_helper"

describe Work do
  describe 'Validation' do

    it 'invalid without a title' do
      work = Work.first
      work.title = nil
      expect( work.valid? ).must_equal false
    end

    it 'invalid with a nonunique title' do
      work = Work.new(title: Work.first.title)
      expect( work.valid? ).must_equal false
    end

    it 'is valid when title is present and unique' do
      work = Work.new(title: 'test title')
      expect( work.valid? ).must_equal true
    end
  end

  describe 'Relations' do
    before do
      @user = User.first
      @work = Work.first
    end

    it 'can add a vote using method votes' do
      vote = Vote.new(user: @user)

      @work.votes << vote
      expect( @work.votes.first ).must_equal vote
    end

    it 'deleting the vote removes it from work' do
      vote = Vote.create(work: @work, user: @user)

      expect( @work.votes.length ).must_equal 1
      vote.destroy
      expect( Work.first.votes.length ).must_equal 0

    end
  end
end
