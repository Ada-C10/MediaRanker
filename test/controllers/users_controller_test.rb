require "test_helper"

describe UsersController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  describe User do
    describe 'validations' do
      before do
        # Arrange
        @user = User.new(username: 'test user')
      end

      it 'is valid when all fields are present' do
        # Act
        result = @user.valid?

        # Assert
        expect(result).must_equal true
      end

      it 'is invalid when all fields are not present' do
        @user.username = nil

        result = @user.valid?

        expect(result).must_equal false
      end

    end
  end
end
