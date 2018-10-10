require "test_helper"

describe Work do

  before do
    @work = Work.new(title: "a work", category: "book")
    @saved_book = works(:book_example)
    # Work.find_by(category: 'book')
  end

  describe 'validations' do
    it 'is valid when a title and a valid category of movie, book, or album is present' do

      empty_hash = {}
      expect(@saved_book.valid?).must_equal true
      expect(@saved_book).must_be_kind_of Work
      expect(@saved_book.errors.messages).must_equal empty_hash
    end

    it 'is is invalid if category and title are nil' do

      @work.title = nil
      @work.category = nil

      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :title, :category
    end

    it 'is is invalid if category is not movie, book, album' do

      @work.category = "film"
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :category
      expect(@work.errors.messages).wont_include :title
    end

    it 'is is invalid without a category' do

      @work.category = nil
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :category
      expect(@work.errors.messages).wont_include :title
    end

    it 'is is invalid without a title' do

      @work.title = nil
      expect(@work.valid?).must_equal false

      expect(@work.errors.messages).must_include :title
      expect(@work.errors.messages).wont_include :category
    end

    it 'is invalid if work of same category and title is created' do
      #TO DO: populate her
      @work.title = @saved_book.title

      expect(@saved_book.category).must_equal 'book'
      expect(@work.category).must_equal 'book'
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :title
    end

    it 'is valid if work of different category but same title is created for movie, book, and album' do
      #TO DO: populate her

      dup_title = @saved_book.title
      empty_hash = {}

      movie = Work.new(title: dup_title, category: 'movie')
      album = Work.new(title: dup_title, category: 'album')

      expect(@saved_book.category).must_equal 'book'
      expect(movie.category).must_equal 'movie'
      expect(album.category).must_equal 'album'
      expect(movie.valid?).must_equal true
      expect(album.valid?).must_equal true
      expect(@work.errors.messages).must_equal empty_hash
    end
  end
end
