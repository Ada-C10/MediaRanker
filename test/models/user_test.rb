require "test_helper"

describe User do

  describe 'validations' do

    before do
      @user = User.new(username: 'testuser')
    end

    it 'is valid when username is present and unique' do

      is_valid = @user.valid?

      expect( is_valid ).must_equal true
    end

    it 'is invalid without a username' do

      @user.username = nil

      is_valid = @user.valid?

      expect( is_valid ).must_equal false
      expect( @user.errors.messages ).must_include :username

    end

    it 'is invalid with a non-unique username' do
      @user.username = User.first.username

      is_valid = @user.valid?

      expect( is_valid ).must_equal false
      expect( @user.errors.messages ).must_include :username
    end
  end

  describe 'relations' do

    it "has some votes" do
      user = User.first

      votes = user.votes

      expect(votes).must_respond_to :each
    end
  end
end
