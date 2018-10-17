require "test_helper"
require "pry"
describe Work do
  let(:work) { works(:work1) }
  let(:work2) { works(:work2) }



  it "must be valid" do
    value(work).must_be :valid?
  end

  it 'has required fields' do
    fields = [:title, :publication_year, :creator, :description, :category]

    fields.each do |field|
      expect(work).must_respond_to field
    end
  end


  describe 'Validations' do
    it 'must have a title' do
      # arrange
      work.title = nil

      #act
      valid = work.save

      #assert
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :title
    end

    it 'must have a valid category:book,movie,album' do
      #arrange
      work.category = nil

      #act
      valid = work.save

      #assert
      expect(valid).must_equal false
    end

    it 'title must be unique to its category' do
      #arrange
      work2.title = 'Harry Potter'

      #act
      valid = work2.save

      #assert
      expect(work2.save).must_equal false
    end

  end

  describe 'Custom Methods' do
    #arrange
    it 'returns an array of albums' do
      albums_array = Work.albums #array of works that are albums

      #act /assert
      albums_array.each do |work|
        expect(work.category).must_equal 'album'
      end
    end

    it 'returns an array of albums ordered by vote count in descending order' do
      albums_array = Work.albums #array of works that are albums
      work1 = albums_array[0]
      work2 = albums_array[1]

      #act /assert
        expect(work1.votes.count > work2.votes.count).must_equal true
    end

    it 'returns an array of albums ordered by title in ascending order' do
      albums_array = Work.albums #array of works that are albums
      albums_array2 = Work.albums.sort

      compare = albums_array.zip(albums_array2).map {|album, album2| album == album2}
      #returns an array of 'true' values if album and album2 are identical

      #assert
      expect(compare.all?).must_equal true
    end

    it 'returns an array of books' do
      books_array = Work.books #array of works that are albums

      #act /assert
      books_array.each do |work|
        expect(work.category).must_equal 'book'
      end
    end

    it 'returns an array of movies' do
      movies_array = Work.movies #array of works that are albums

      #act /assert
      movies_array.each do |work|
        expect(work.category).must_equal 'movie'
      end
    end


  end

  describe 'Relationships' do
    it 'has a list of votes' do
      work.must_respond_to :votes

      work.votes.each do |vote|
        vote.must_be_kind_of Vote
      end
    end

    it 'has a list of users through votes' do
      work.votes.each do |vote|
        vote.must_respond_to :user_id
      end
    end
  end


  # def self.movies
  #   return Work.where(category: 'movie')
  # end

  #make sure it returns an instance of Array
  #make sure each category inside is


end
