require "test_helper"

describe Work do

  describe 'validations' do
    before do
      @work = works(:harry_potter)
    end

    it 'is valid when all required field are present' do
      expect(@work.valid?).must_equal true
      expect(@work.errors.messages).must_be_empty
    end

    it 'is invalid without category' do
      @work.category = nil
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :category
    end

    it 'is invalid without title' do
      @work.title = nil
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :title
    end

    it 'is invalid without creator' do
      @work.creator = nil
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :creator
    end

    it 'is invalid without integer publication year' do
      @work.publication_year = "ninety"
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :publication_year
    end
  end

  # desribe 'relations' do
  #   before do
  #   end
  #   it 'responds to '
  # end
end
