require "test_helper"

describe Work do
  describe 'validations' do
    it 'has a title' do
      work = works(:beatles)

      work.title = nil

      is_valid = work.valid?

      expect( is_valid ).must_equal false
      expect( work.errors.messages ).must_include :title
    end

    it 'has a unique title' do
      work = works(:potter)

      new_work = Work.new(category: 'book', title: work.title, creator: 'Jon Snow', publication_year: 1990, description: 'Creating a new description here')

      is_valid = new_work.valid?

      expect( is_valid ).must_equal false
      expect( new_work.errors.messages).must_include :title

    end

    it 'is valid when all fields are present' do
      work = works(:beatles)

      is_valid = work.valid?

      expect( is_valid ).must_equal true

    end


  end
end
