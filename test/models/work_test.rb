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
end
