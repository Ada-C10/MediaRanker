require "test_helper"

require 'pry'

describe User do

  before do
    @user = User.create!(username: "Julia")
    @saved_user = users(:first)
    #User.first
  end

  describe 'validations' do
    it 'is valid when a username is present' do

      empty_hash = {}

      expect(@saved_user.valid?).must_equal true
      expect(@saved_user).must_be_kind_of User
      expect(@saved_user.errors.messages).must_equal empty_hash
    end

    it 'is is invalid if username is nil' do

      @user.username = nil

      expect(@user.valid?).must_equal false
      expect(@user.errors.messages).must_include :username
    end

    it 'is invalid if user of same username is created' do
      #TO DO: populate her
      @user.username = @saved_user.username

      expect(@saved_user.username).must_equal 'first-name123'
      expect(@user.username).must_equal 'first-name123'
      expect(@user.valid?).must_equal false
      expect(@user.errors.messages).must_include :username
    end
  end
end
