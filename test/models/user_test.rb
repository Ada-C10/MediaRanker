require "test_helper"

describe User do
  describe "validations" do
    let(:user) { User.new }

    it "must be invalid when fields are left blank" do
      value(user.valid?).must_equal false
    end

    it "is valid when username is provided" do
      user1 = users(:user1)

      value(user1.valid?).must_equal true
    end

    it "is invalid if the username is not unique" do
      user1 = users(:user1)
      user2 = User.create(username: "Vinnie")

      value(user1.valid?).must_equal true
      value(user2.valid?).must_equal false
    end

    it "is invalid if the username is not between 3 and 20 characters" do
      user1 = User.create(username: "ksaksadkjfalladfkjafdlajfkasdlkjfjasdlfkjadslfjk")
      user2 = User.create(username: "t")

      value(user1.errors.messages).must_include :username
      value(user2.errors.messages).must_include :username
    end
  end
end
