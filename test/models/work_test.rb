require "test_helper"

describe Work do
  let(:work) { works(:harrypotter)  }

  it "must be valid" do
    expect(work).must_be :valid?
  end

  it 'has required fields' do
    fields = [:title, :creator, :description, :publication_year, :category]

    fields.each do |field|
      expect(work).must_respond_to field
    end
  end

  describe 'Relationships' do
    it 'can have many votes' do
      # Arrange (done with let)
      work = works(:harrypotter)
      vote1 = votes(:voteone)
      # Act
      vote = work.votes

      # Assert
      expect(vote).must_be_instance_of Vote
      expect(vote.id).must_equal work.votes_id
    end
  #
  #   it 'can have many users' do
  #     # Arrange, did with let
  #
  #     # Act
  #     book.genres << Genre.first
  #     genres = book.genres
  #
  #
  #     # Assert
  #     expect(genres.length).must_be :>=, 1
  #     genres.each do |genre|
  #       expect(genre).must_be_instance_of Genre
  #     end
  #   end
  end

  describe 'validations' do
    it 'must have a title' do
      # Arrange
      work = works(:harrypotter)
      work.title = nil

      # Act
      #valid = book.valid?
      valid = work.save

      # Assert
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it 'cannot have category other than movie, album or book' do
      # Arrange
      work = works(:harrypotter)

      [nil, "art", 123, "indie"].each do |cat|
        work.category = cat
        valid = work.save
        expect(valid).must_equal false
        expect(work.errors.messages).must_include :category
      end
    end

    it 'must have category movie, album or book' do
      # Arrange
      work = works(:harrypotter)

      ["movie", "album", "book"].each do |cat|
        work.category = cat
        valid = work.save
        expect(valid).must_equal true
      end

    end

    it 'requires a unique title in category' do
      #other_book = book.clone
      other_work = works(:pride)
      other_work.title = work.title
      other_work.category = work.category

      valid = other_work.valid?

      expect(valid).must_equal false
      expect(other_work.errors.messages).must_include :title
    end

    it 'will allow a title that already exists if its in a different category' do
      #other_book = book.clone
      other_work = works(:pride)
      other_work.title = work.title

      valid = other_work.valid?

      expect(valid).must_equal true
    end
  end

  describe 'Media Page - Methods' do
    it 'return top 10 of a given category' do
      ten_movies = Work.top_movies
      expect(ten_movies.length).must_equal 10
      ten_movies.each do |movie|
        expect(movie.category).must_equal "movie"
      end
    end

    it 'will only return 10 if there are more than 10 in a category' do
      new_movie = Work.new
      new_movie.title = "some movie"
      new_movie.category = "movie"
      new_movie.save

      ten_movies = Work.top_movies

      expect(ten_movies.length).must_equal 10
    end

    it 'will only return less than 10 works if there are less than 10 in the category' do

      ten_books = Work.top_books

      expect(ten_books.length).must_equal 1
    end
  end
end
