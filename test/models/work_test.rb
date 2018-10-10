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
      # expect(valid_work).must_be_instance_of Work
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
      # Arrange
      @work.category = Work.first.category

      # Act
      is_valid = @work.valid?

      # Assert
      expect(is_valid).must_equal true

      # Expected true (TrueClass) to respond to #category.
      # test/models/work_test.rb:58:in `block (3 levels) in <main>'?????
      # expect(is_valid).must_respond_to :category
    end

    it 'has a publication year that has only integers' do

    end

    # it 'has a description' do
    #
    # end

  end
end
