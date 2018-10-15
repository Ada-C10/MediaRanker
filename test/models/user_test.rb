require "test_helper"
require "pry"

describe User do
  describe 'validations' do
    before do
      @user = User.new(
        name: 'Charles',
      )
    end

    it 'is valid when name is present' do
      is_valid = @user.valid?
      expect(is_valid).must_equal true

    end

    it 'is invalid without a name' do
      @user.name = nil

      is_valid = @user.valid?

      expect(is_valid).must_equal false
      expect(@user.errors.messages ).must_include :name
    end


    it 'is invalid with a non-unique name' do
      @user.name = User.first.name

      is_valid = @user.valid?

      expect( is_valid ).must_equal false
      expect( @user.errors.messages ).must_include :name
    end

  end

  describe "relations" do
    it "has a vote" do
      user = users(:jim)
      user.votes.must_include votes(:one)
    end
  end

end
