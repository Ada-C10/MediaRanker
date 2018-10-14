require "test_helper"


describe Work do
  let(:work) { works(:hello) }
  let(:work2) { works(:pride) }
  let(:work3) { works(:taken) }

  it "must be valid" do
    value(work).must_be :valid?
  end

  it 'has required fields' do
    fields = [:category, :title, :creator, :publication_year, :description]

    fields.each do |field|
      expect(work).must_respond_to field
    end
  end

  describe 'Relationships' do
    it 'can have many votes' do

      work.votes << Vote.first
      votes = work.votes

      expect(votes.length).must_be :>=, 1
      votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe 'validations' do
    it 'must have a title' do

      work.title = nil

      valid = work.save

      expect(valid).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank","is too short (minimum is 3 characters)"]
    end


    it 'requires a unique title' do

      other_work = Work.new
      other_work.title = work.title
      other_work.category = 'album'

      valid = other_work.valid?

      expect(valid).must_equal false
      expect(other_work.errors.messages).must_include :title
    end

    it 'must have a category' do

      work.category = nil

      valid = work.valid?

      expect(valid).must_equal false
      expect(work.errors.messages).must_include :category
      expect(work.errors.messages[:category]).must_equal ["can't be blank", "is not included in the list"]
    end

    it 'must have a category of book, album or movie' do
       work.category = "boo"
       valid = work.valid?
       expect(valid).must_equal false

       work.category = "book"
       valid = work.valid?
       expect(valid).must_equal true

       work.category = "albu"
       valid = work.valid?
       expect(valid).must_equal false

       work.category = "album"
       valid = work.valid?
       expect(valid).must_equal true

       work.category = "movie"
       valid = work.valid?
       expect(valid).must_equal true
    end
  end

  describe 'self.book_list' do
    it 'returns an array ' do
      expect(Work.book_list).must_be_instance_of Array
    end

    it 'includes instances of work with the category of book' do
      expect(Work.book_list.first).must_be_instance_of Work
      expect(Work.book_list.first.category).must_equal 'book'
    end

    it 'return the right number of books' do
      expect(Work.book_list.count).must_equal 1
    end

    it 'return the books ordered by votes' do
      work3.category = "book"
      work3.save
      expect(Work.book_list.first).must_equal work2
    end

    it 'returns an empty array when no works in book category' do
      work2.category = "movie"
      work2.save
      expect(Work.book_list).must_equal []
    end
  end

  describe 'self.album_list' do
    it 'returns an array ' do
      expect(Work.album_list).must_be_instance_of Array
    end

    it 'includes instances of work with the category of album' do
      expect(Work.album_list.first).must_be_instance_of Work
      expect(Work.album_list.first.category).must_equal 'album'
    end

    it 'return the right number of albums' do
      expect(Work.album_list.count).must_equal 1
    end

    it 'return the albums ordered by votes' do
      work3.category = "album"
      work3.save
      expect(Work.album_list.first).must_equal work
    end

    it 'returns an empty array when no works in album' do
      work.category = "movie"
      work.save
      expect(Work.album_list).must_equal []
    end
  end

  describe 'self.movie_list' do

    it 'returns an array ' do
      expect(Work.movie_list).must_be_instance_of Array
    end

    it 'includes instances of work with the category of movie' do
      expect(Work.movie_list.first).must_be_instance_of Work
      expect(Work.movie_list.first.category).must_equal 'movie'
    end

    it 'return the right number of movies' do
      work2.category = "movie"
      work2.save
      expect(Work.movie_list.count).must_equal 2
    end

    it 'return the movies ordered by votes' do
      work2.category = "movie"
      work2.save
      expect(Work.movie_list.first).must_equal work2
    end

    it 'returns an empty array when no works in movie category' do
      work3.category = "album"
      work3.save
      expect(Work.movie_list).must_equal []
    end

  end

  describe 'self.top_one' do

    it 'returns a work ' do
      expect(Work.top_one).must_be_instance_of Work
    end

    it 'return the work with most votes' do
      work3.category = "book"
      work3.save
      tony = users(:tony)
      Vote.create(user:tony, work:work2)
      expect(Work.top_one).must_equal work2
    end

    it 'pick just one work if two works tie in the most votes' do
      expect(Work.top_one).must_equal work
    end

  end

end
