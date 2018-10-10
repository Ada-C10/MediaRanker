require "test_helper"

describe Work do

  describe 'validations' do

    it 'creates a new instance of work' do
      work = Work.new
      expect(work).must_be_instance_of Work
    end

    it 'is valid with all field in work complete' do
      work = works(:book)
      expect(work.valid?).must_equal true
    end

    it 'is invalid if title is blank' do
      work = works(:album)
      expect(work.valid?).must_equal false
    end

    it 'is invalid if title is not unique' do
      work = works(:book)
      work = Work.new(title: "Harry Potter and the Goblet of Fire" )

      expect(work.valid?).must_equal false
    end

    it 'is invalid if title is not longer than 5 char' do
      work = works(:movie)

      expect(work.valid?).must_equal false
    end

    it 'is invalid if creator is not present' do
      work = works(:creator)
      expect(work.valid?).must_equal false
    end

    it 'is invalid if publication year is not a number' do
      work = works(:publication)
      expect(work.valid?).must_equal false
    end

    it 'is invalid if description is not a blank' do
      work = works(:publication)
      expect(work.valid?).must_equal false
    end

    it 'is invalid if publication_year is less than 999 and greater than 10000' do
      less = Work.new(publication_year: 998)
      more = Work.new(publication_year: 10001)

      expect(less.valid?).must_equal false
      expect(more.valid?).must_equal false
      expect(less.errors.messages).must_include :publication_year
    end

    describe 'relations' do
    end

  end
end
