require "test_helper"

describe Work do
  let(:work) {works(:rambo) }
  describe 'validations' do

    it 'is valid when all fields are present' do
      result = work.valid?
      expect(result).must_equal true
    end

    it 'is invalid when title is missing' do
      work.title = nil
      result = work.valid?
      expect(result).must_equal false
      expect(work.errors.messages).must_include :title
    end

    it 'requires a unique name' do
      other_work = works(:reputation)
      other_work.title = work.title
      valid = other_work.valid?
      expect(valid).must_equal false
      expect(other_work.errors.messages).must_include :title

    end

    it 'will only be valid with a correct category' do
      work.category = "ebook"
      valid = work.valid?
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :category
    end

  end

  describe 'relations' do
    it 'can have many votes' do

    end
  end

  describe 'custom methods' do

  end
end
