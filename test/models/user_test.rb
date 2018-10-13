require "test_helper"

describe User do
  describe 'validations' do

    # note to self: .valid? checks against yaml file
    it 'is a valid user if the username is present and unique' do
      new_user = User.new(username: "toby")
      is_valid = new_user.valid?
      expect(is_valid).must_equal true
    end

    it 'is not a valid user if the username is absent' do
      new_user = User.new
      is_valid = new_user.valid?
      expect(is_valid).must_equal false
    end

    it 'is not a valid user if the username is present but not unique' do
      new_user = User.new(username: "june")
      is_valid = new_user.valid?
      expect(is_valid).must_equal false
    end
  end
end
