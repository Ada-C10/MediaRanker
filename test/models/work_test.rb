require "test_helper"

describe Work do
  describe 'validations' do
    it 'has a title' do
      work = Work.new(title: nil, category: 'album', creator: 'test_creator', publication_year: 1989, description: 'this is the test description')

      is_valid = work.valid?

      expect( is_valid ).must_equal false
    end

  
  end
end
