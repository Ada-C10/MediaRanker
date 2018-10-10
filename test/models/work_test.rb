require "test_helper"

describe Work do
  let(:work) { works(:harry_potter) }


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
  end


  # def self.movies
  #   return Work.where(category: 'movie')
  # end

  #make sure it returns an instance of Array
  #make sure each category inside is


end
