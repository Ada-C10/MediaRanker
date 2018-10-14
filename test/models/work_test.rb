require "test_helper"

describe Work do

  describe 'validations' do
    before do
      @work = Work.new(
        title: 'test work',
        creator: 'test author',
        category: 'book',
        publication_year: 1988,
        description: 'description here'
      )
    end

    it 'is valid when title is present and unique, creator is present, and publication year is present and of a reasonable year for media creation' do

      is_valid = @work.valid?
      expect(is_valid).must_equal true

    end

    it 'is invalid without a title' do
      @work.title = nil

      expect(@work.valid?).must_equal false
    end

    it 'is invalid if title and creator combination is not-unique' do
      @work.title = Work.first.title
      @work.creator = Work.first.creator
      puts Work.first.title

      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :title
    end

    it 'is invalid without a creator' do
      @work.creator = nil

      expect(@work.valid?).must_equal false
    end

    it 'is invalid without a publication_year' do
      @work.publication_year = nil

      expect(@work.valid?).must_equal false
    end

    it 'is invalid if publication year is not a number ' do
      @work.publication_year = 'Not a number'

      expect(@work.valid?).must_equal false
    end

    it 'is invalid if publication_year is less than 0 (BC)' do
      @work.publication_year = -1

      expect(@work.valid?).must_equal false
    end

    it 'is invalid if publication_year is further than 1 year into the future' do
      @work.publication_year = Date.today.year + 2

      expect(@work.valid?).must_equal false
    end
  end

  describe 'relations' do
    it 'has some votes' do
      w = Work.find_by(title: 'Princess Bride')
      # test data has 2 votes in votes.yml

      votes = w.votes

      expect(votes).must_respond_to :each
      expect(votes.count).must_equal 2
    end
  end

  describe 'top_ten method' do
    it 'returns a collection of works' do
      ['movie', 'album', 'book'].each do |category|
        works = Work.top_ten(category)
        expect(works).must_respond_to :each
      end
    end

    it 'returns a maximum 10 works' do
      ['movie', 'album', 'book'].each do |category|
        works = Work.top_ten(category)
        expect(works.count).must_be :<=, 10
      end
    end

    it 'returns a list of works in order of decreasing vote count' do
      works = Work.top_ten('movie')
      vote_count = works.first.votes.count
      9.times do |place_num|
        next_vote_count = works[place_num + 1].votes.count
        expect(vote_count >= next_vote_count).must_equal true
        vote_count = next_vote_count
      end
    end
  end

  describe 'get_works_of_type method' do
    it 'returns a collection of works' do
      ['movie', 'album', 'book'].each do |category|
        works = Work.get_works_of_type(category)
        expect(works).must_respond_to :each
      end
    end

    it 'returns the entire collection of works for each category' do
      ['movie', 'album', 'book'].each do |category|

        actual_count = Work.where(category: category).count

        works = Work.get_works_of_type(category)

        expect(works.count).must_equal actual_count
      end
    end

    it 'returns [] if the category does not match any of the media categories' do
      works = Work.get_works_of_type('no match')
      expect(works).must_equal []
    end

    it 'returns [] if given nil category' do
      works = Work.get_works_of_type(nil)
      expect(works).must_equal []
    end


  end

  describe 'get_categories' do
    it 'returns the list of media categories' do
      expected_array =['album', 'book', 'movie'].sort

      given_array = Work.get_categories.sort

      expect(given_array).must_equal expected_array
    end
  end

  describe 'top_media' do
    it 'returns the work with the most votes' do
      expected_top = works(:moana)

      given_top = Work.top_media

      expect(given_top).must_equal expected_top
    end
  end

  describe 'get_num_votes' do
    before do
      @work = Work.new(
        title: 'test work',
        creator: 'test author',
        category: 'book',
        publication_year: 1988,
        description: 'description here'
      )
    end

    it 'returns the number of votes for a given work' do
      work = Work.top_media

      expected_count = work.votes.count

      given_count = work.get_num_votes

      expect(expected_count).must_equal given_count
    end

  end

end
