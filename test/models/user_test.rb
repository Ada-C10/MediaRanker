require "test_helper"

describe User do
  let(:user) { users(:one) }

  it "must be valid" do
    expect(user).must_be :valid?
  end

  describe "validations" do
    it "won't be valid without username" do
      user = users(:one)
      user.username = nil

      result = user.valid?

      expect(result).wont_equal true
    end

    it "will be valid with a username" do
      result = user.valid?
      expect(result).must_equal true
    end

    it "won't be valid without unique username" do
      new_user = User.new(username: "griffiam")

      result = new_user.valid?

      expect(result).wont_equal true
    end

    it "will be valid with unique username" do
      newest_user = User.new(username: "guru")

      new_result = newest_user.valid?

      expect(new_result).must_equal true
    end

  end
end
