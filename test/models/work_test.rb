require "test_helper"

describe Work do
  describe 'validations' do
    before do
      # Arrange
      @work = works(:one)
    end

    it 'is valid when all fields are present' do
      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal true
    end

    it 'is not valid when some fields are not present' do
      # Act
      work = works(:two)
      work.category = nil
      result = work.valid?

      # Assert
      expect(result).must_equal false
    end
  end
end
