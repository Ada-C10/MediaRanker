require "test_helper"

require 'pry'

describe Work do

  before do
    @work = Work.new(title: "a work", category: "book")
  end

  describe 'validations' do
    it 'is valid when a title and a valid category of movie, book, or album is present' do

      work = Work.first
      empty_hash = {}
      expect(work.valid?).must_equal true
      expect(work).must_be_kind_of Work
      expect(work.errors.messages).must_equal empty_hash
    end

    it 'is is invalid if category and title are nil' do

      @work.title = nil
      @work.category = nil

      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :title, :category
    end

    it 'is is invalid if category is not movie, book, album' do

      @work.category = "film"
      @work.title = "a work"
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
      @work.category = "book"
      expect(@work.valid?).must_equal false

      expect(@work.errors.messages).must_include :title
      expect(@work.errors.messages).wont_include :category
    end

    it 'is invalid if work of same category and title is created' do
      #TO DO: populate her
    end

    it 'is invalid if work of different category but same title is created' do
      #TO DO: populate her
    end
  end
end
