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
end
