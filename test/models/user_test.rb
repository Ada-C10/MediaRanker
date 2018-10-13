require "test_helper"

describe User do
  before do
    @user = users(:val)
  end

  describe 'validations' do

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

  describe 'relations' do

    it 'responds to votes method' do
      expect(@user.votes).must_respond_to :each
    end

    it 'responds to upvoted_works method' do
      expect(@user.upvoted_works).must_respond_to :each
    end

  end
end
