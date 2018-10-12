require "test_helper"

describe Medium do

  describe 'validations' do
    before do
      @medium = Medium.new(
        title: 'CyberBabies on High',
        description: 'cannot recommend this book in good conscience',
        category: 'book',
        creator: 'Jarth Dengees',
        publication_year: 1999
      )
    end

    it 'is valid when title is present and unique, creator and category are present, and publication_year is both numerical and present' do

      is_valid = @medium.valid?
      expect( is_valid ).must_equal true

    end

    it 'is invalid without a title' do
      @medium.title = nil

      is_valid = @medium.valid?

      expect( is_valid ).must_equal false
      expect( @medium.errors.messages ).must_include :title
    end

    it 'is invalid with a non-unique title' do
      @medium.title = Medium.first.title

      is_valid = @medium.valid?

      expect( is_valid ).must_equal false
      expect( @medium.errors.messages ).must_include :title
    end

    it 'is invalid without a creator' do
      @medium.creator = nil

      is_valid = @medium.valid?

      expect( is_valid ).must_equal false
      expect( @medium.errors.messages ).must_include :creator
    end

    it 'is invalid without a category' do
      @medium.category = nil

      is_valid = @medium.valid?

      expect( is_valid ).must_equal false
      expect( @medium.errors.messages ).must_include :category
    end

    it 'is invalid without a publication_year' do
      @medium.publication_year = nil

      is_valid = @medium.valid?

      expect( is_valid ).must_equal false
      expect( @medium.errors.messages ).must_include :publication_year
    end

    it 'is invalid when publication_year is non-numeric' do
      @medium.publication_year = "beetlejuice beetlejuice beetlejuice"

      is_valid = @medium.valid?

      expect( is_valid ).must_equal false
      expect( @medium.errors.messages ).must_include :publication_year
    end
  end

end
