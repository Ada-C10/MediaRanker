require "test_helper"

describe User do

  describe 'validations' do
    before do
      @user = User.new(name: 'valgidzi')
    end

    it 'is valid when all required field are present' do
      expect(@user.valid?).must_equal true
    end

    it 'is invalid without category' do
      @user.name = nil
      expect(@user.valid?).must_equal false
    end

  end
end
