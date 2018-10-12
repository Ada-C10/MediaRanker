require "test_helper"

describe Work do
  describe 'validations' do
    before do
      # Arrange
      @work = Work.new(title: 'test')
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
  end
end
