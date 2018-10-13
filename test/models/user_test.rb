require "test_helper"

describe User do

  describe 'validations' do
    before do
      @user = users(:val)
    end

    it 'is valid when all required field are present' do
      expect(@user.valid?).must_equal true
      expect(@user.errors.messages).must_be_empty
    end

    it 'is invalid without category' do
      @user.name = nil
      expect(@user.valid?).must_equal false
      expect(@user.errors.messages).must_include :name
    end

  end
end
