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

    it 'has a unique title within the same category' do
      work = works(:potter)

      new_work = Work.new(category: work.category, title: work.title, creator: 'Jon Snow', publication_year: 1990, description: 'Creating a new description here')

      is_valid = new_work.valid?

      expect( is_valid ).must_equal false
      expect( new_work.errors.messages).must_include :title
    end

    it 'is valid with same title in different categories' do
      work = works(:greys)

      new_work = Work.new(category: 'album' , title: work.title, creator: 'Derek Shepherd', publication_year: 2010, description: 'Some sort of window to your right as he goes left, and you stay right')

      is_valid = new_work.valid?

      expect( is_valid ).must_equal true
    end


    it 'is valid when all fields are present' do
      work = works(:beatles)

      is_valid = work.valid?

      expect( is_valid ).must_equal true

    end

    it 'is only valid with a correct category' do
      work = works(:greys)

      work.category = "podcast"

      is_valid = work.valid?

      expect( is_valid ).must_equal false

      Work::CATEGORY.each do |c|
        work.category = c

        still_valid = work.valid?

        expect( still_valid ).must_equal true
      end

    end


  end
end
