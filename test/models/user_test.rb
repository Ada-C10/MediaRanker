require "test_helper"

describe User do
  describe 'User validations - presence' do
     before do
       # Arrange
       @user = User.create(name: 'test name')
     end

     it 'is valid when all fields are present' do
       # Act
       result = @user.valid?

       # Assert
       expect(result).must_equal true
     end
   end
end
