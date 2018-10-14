require "test_helper"

describe Work do
  describe 'validations' do
    before do
      # Arrange
      @work = Work.new(category: 'book', title: 'nice title')
    end

    it 'is valid when all fields are present' do
      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal true
    end

    it 'is invalid without a category' do
      # Arrange
      @work.category = nil

      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :category
    end

    it "is invalid without a title" do
      @work.title = nil
      result = @work.valid?

      expect(result).must_equal false
      expect(@work.errors.messages).must_include :title
    end

    it "is invalid if same title already exists" do
      @work.save
      @new_work = Work.new(category: 'book', title: @work.title)
      result = @new_work.valid?

      expect(result).must_equal false
    end
  end
end
