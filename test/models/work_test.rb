require "test_helper"

describe Work do
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
  end

  it "is invalid without a title" do
    @work.title = nil
    result = @work.valid?

    expect(result).must_equal false
  end
end
