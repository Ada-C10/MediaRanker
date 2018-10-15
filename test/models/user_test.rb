require "test_helper"

describe User do
  describe 'validations' do

    it "is valid with username provided" do
      user = users(:rigo)
      result = user.valid?

      expect(result).must_equal true
    end

    it "is invalid if username is not present" do
      user = User.new
      result = user.valid?

      expect(result).must_equal false
      expect(user.errors.messages).must_include :username
    end

    it "is invalid if username is nil" do
      user = User.new(username: "chai")
      user.username = nil
      result = user.valid?

      expect(result).must_equal false
      expect(user.errors.messages).must_include :username
    end

    it "is invalid when username is not unique" do
      user = User.new(username: users(:donnie).username)
      result = user.valid?

      expect(result).must_equal false
      expect(user.errors.messages).must_include :username
    end

  end
end
