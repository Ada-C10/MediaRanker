require "test_helper"

describe Work do
  describe 'validations' do
    before do
      @work = Work.new(
        title: 'Beanstock',
        description: 'this is a test',
        year_published: 1999,
        #this creator will be replaced by User
        created_by: 'Carly',
        category: 'Movie'
      )
    end

    it 'is valid when title, creator, and category are present' do

      is_valid = @work.valid?
      expect(is_valid ).must_equal true

    end

    it 'is invalid without a title' do
      @work.title = nil

      is_valid = @work.valid?

      expect( is_valid ).must_equal false
      expect( @work.errors.messages ).must_include :title
    end

    it 'is invalid without a creator' do
      @work.created_by = nil

      is_valid = @work.valid?

      expect( is_valid ).must_equal false
      expect( @work.errors.messages ).must_include :created_by
    end

    it 'is invalid without a category' do
      @work.category = nil

      is_valid = @work.valid?

      expect( is_valid ).must_equal false
      expect( @work.errors.messages ).must_include :category
    end

  end
end
