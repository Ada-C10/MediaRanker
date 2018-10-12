require "test_helper"

describe User do
  describe 'validations' do
    before do
      @user = User.new(username: 'test')
    end

    it 'is invalid without a username' do
      @user.username = nil

      result = @user.valid?

      expect(result).must_equal false
      expect( @user.errors.messages ).must_include :username

    end

    it 'is invalid with a non-unique username' do
      @user.username = User.first.username
      result = @user.valid?
      expect(result).must_equal false
      expect( @user.errors.messages ).must_include :username
    end
  end
end


# require "test_helper"
#
# describe Work do
#   describe 'validations' do
#     before do
#       # Arrange
#       @work = Work.new(title: 'test')
#     end
#
#     it 'is invalid without a title' do
#     # Arrange
#     @work.title = nil
#
#     # Act
#     result = @work.valid?
#
#     # Assert
#     expect(result).must_equal false
#     expect(@work.errors.messages).must_include :title
#     end
#   end
# end
