require "test_helper"

describe User do
  let(:user) { User.new(name: 'test') }

  it "must be valid" do
    value(user).must_be :valid?
  end

  describe 'validations' do
    before do
      @user = User.new(
        name: 'test user')
    end

    it 'is valid when name is present and unique' do

      is_valid = @user.valid?
      expect( is_valid ).must_equal true
    end

    it 'is invalid with a non-unique name' do
      @user.name = User.first.name

      is_valid = @user.valid?

      expect( is_valid ).must_equal false
      expect( @user.errors.messages ).must_include :name
    end

    it 'is invalid with a missing name' do
      @user.name = nil

      is_valid = @user.valid?

      expect( is_valid ).must_equal false

      expect ( @user.errors.messages ).must_include :name
    end
  end
end
