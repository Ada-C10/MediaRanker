require "test_helper"

describe WorksController do

  describe Work do
    describe 'validations' do
      before do
        # Arrange
        @work = Work.new(title: 'test work')
      end

      it 'is valid when all fields are present' do
        # Act
        result = @work.valid?

        # Assert
        expect(result).must_equal true
      end

      it 'is invalid when all fields are not present' do
        @work.title = nil

        result = @work.valid?

        expect(result).must_equal false
      end

    end
  end
end
