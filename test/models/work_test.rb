require "test_helper"
require 'pry'

describe Work do

  # VALIDATIONS TESTS
  describe 'validations' do

    it 'is not valid without a title' do
      work = works(:beatles)

      work.title = nil

      expect( work ).must_be :invalid?
      expect( work.errors.messages ).must_include :title
    end

    it 'is not valid without a unique title within the same category' do
      work = works(:greys)
      new_work = works(:titanic)

      new_work.title = work.title

      expect( new_work).must_be :invalid?
      expect( new_work.errors.messages ).must_include :title
    end

    it 'is valid with same title but in different categories' do
      work = works(:greys)

      new_work = works(:potter)

      new_work.title = work.title

      expect( new_work ).must_be :valid?
    end


    it 'is valid when all fields are present' do
      work = works(:beatles)

      expect( work ).must_be :valid?

    end

    it 'is only valid with a correct category' do
      work = works(:greys)

      work.category = "podcast"

      expect( work ).must_be :invalid?

      Work::CATEGORIES.each do |c|
        work.category = c

        expect( work ).must_be :valid?
      end

    end
  end


    # RELATIONS TESTS
    describe 'relations' do
      it 'must relate to a vote' do
        work = works(:potter)

        expect( work ).must_respond_to :votes
      end

      it 'returns returns an array of votes when using the votes method call' do
        work = works(:potter)
        votes = work.votes

        expect( work.votes.first ).must_be_kind_of Vote
        expect( work.votes.count ).must_equal 5
      end
    end

    # CUSTOM METHODS TESTS
    describe 'top_media' do
      it 'returns only 10 works' do
        works = Work.top_media('book')

        expect( works.count ).must_equal 10
      end

      it 'returns the 10 works in descending order based on votes' do
        works = Work.top_media('book')

        expect( works.first ).must_equal works(:potter)
        expect( works.last ).wont_equal works(:potter)
      end

      it 'returns only the works of the same category' do
        works = Work.top_media('book')

        works.each do |w|
          category = w.category

          expect( category ).must_equal 'book'
        end

      end
    end

    describe 'spotlight' do
      it 'returns the work with the most amount of votes' do
        most_votes = Work.spotlight

        expect( most_votes ).must_equal works(:potter)
      end


    end

    describe 'get_all_works' do
      let(:albums) { Work.get_all_works('album') }
      let(:books) { Work.get_all_works('book') }
      let(:movies) { Work.get_all_works('movie') }

      it 'returns all the works for each category' do

        expect( albums.count ).must_equal 2
        expect( books.count ).must_equal 11
        expect( movies.count ).must_equal 3
      end

      it 'returns only the works of the specific category' do
        albums.each do |a|
          category = a.category

          expect( category ).must_equal 'album'
        end

        books.each do |a|
          category = a.category

          expect( category ).must_equal 'book'
        end

        movies.each do |a|
          category = a.category

          expect( category ).must_equal 'movie'
        end
      end

    end


end
