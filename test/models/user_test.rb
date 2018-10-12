require "test_helper"

describe User do

  describe 'validations' do

    before do
      @user = User.new(
        name: 'A Hoe Called Alesse'
      )
    end

    it 'is valid when name is present and unique' do
      is_valid = @user.valid?
      expect( is_valid ).must_equal true
    end

    it 'is invalid without a name' do
      @user.name = nil

      is_valid = @user.valid?

      expect( is_valid ).must_equal false
    end

    it 'is invalid with a non-unique name' do
      @user.name = users(:one).name

      is_valid = @user.valid?

      expect( is_valid ).must_equal false
    end

  end

  describe 'relations' do

    before do
      @user = users(:one)
      user_id = @user.id

      # create 3 vote instances for @user
      Vote.create!( user_id: user_id, medium_id: media(:one).id )
      Vote.create!( user_id: user_id, medium_id: media(:two).id )
      Vote.create!( user_id: user_id, medium_id: media(:three).id )
    end

    it 'can access votes through instance method' do
      votes = @user.votes
      expect( votes.length ).must_equal 3
    end

  end

end
