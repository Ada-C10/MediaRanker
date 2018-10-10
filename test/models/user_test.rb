require "test_helper"

describe User do

  describe 'validations' do

    it 'creates a new user' do
      user = User.new
      expect(user).must_be_instance_of User
    end

    it "is a valid username" do
      user = users(:jazz)
      expect(user.valid?).must_equal true
    end

    it 'is an invalid username name blank' do
      user = users(:blank)
      expect(user.valid?).must_equal false
    end

    it 'is an invalid length for a username' do
      user = users(:tierney)
      expect(user.valid?).must_equal false
    end

    it 'is an invalid username duplicate' do
      user = users(:jazz)
      user = User.new(username: "jazztaz")
      expect(user.valid?).must_equal false
    end

  end

  describe 'relations' do
  end


end
