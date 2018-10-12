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
      @work = Work.find_by(title: 'Bonito Generation')
    end

    it 'can add a vote using method votes' do
      vote = Vote.new(user: @user)

      @work.votes << vote
      expect( @work.votes.last ).must_equal vote
    end

    it 'deleting the vote removes it from work' do
      initial_votes = @work.votes.length

      vote = Vote.new(work: @work, user: @user)
      vote.save

      @work.reload
      expect( @work.votes.length - initial_votes ).must_equal 1

      vote.destroy

      @work.reload
      expect( @work.votes.length - initial_votes ).must_equal 0

    end
  end

  describe 'custom methods' do
    describe 'sort by votes' do

      it 'only accepts a valid category' do
        expect{
          Work.sort_by_votes('pets')
        }.must_raise(ArgumentError)
      end

      it 'sorts works by number of votes in descending order' do
        sorted_movies = Work.sort_by_votes('movie')

  
        expect( sorted_movies.first.title ).must_equal 'Titanic'
        expect( sorted_movies.last.title ).must_equal 'Bonito Generation'
      end
    end
  end
end
