require "test_helper"

# describe Work do
#   let(:work) { Work.new }
#
#   it "must be valid" do
#     value(work).must_be :valid?
#   end

describe Work do
  describe 'validations' do
    before do
      @work = Work.new(title: 'test work', publication_year: 2018, description: 'some description', creator: 'some creator', category: 'movie')
    end

    it 'is valid when all fields are present' do
      # Arrange & Act
      valid_work = @work.valid?

      # Assert
      expect(@work).must_be_instance_of Work
      expect(valid_work).must_equal true
    end

    it 'is invalid without a title' do
      # Arrange
      @work.title = nil

      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :title
    end

    it 'has a unique title' do
      # Arrange
      @work.title = Work.first.title

      # Act
      is_valid = @work.valid?

      # Assert
      expect(is_valid).must_equal false
      expect(@work.errors.messages).must_include :title
    end

    it 'has one of three valid categories' do
      @work.category = "album"
      expect(@work.valid?).must_equal true

      @work.category = "movie"
      expect(@work.valid?).must_equal true

      @work.category = "book"
      expect(@work.valid?).must_equal true

      @work.category = "FAKE"
      expect(@work.valid?).must_equal false
    end

    it 'only accepts publication year as an integer' do
      @work.publication_year = 1234
      expect(@work.valid?).must_equal true

      @work.publication_year = "1234"
      expect(@work.valid?).must_equal true

      @work.publication_year = "abcd"
      expect(@work.valid?).must_equal false
    end

    it 'responds to votes' do

    end

  end
end
