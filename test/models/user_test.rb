require "test_helper"

describe User do
  let(:user) { users(:one)}

  it "must be valid" do
    value(user).must_be :valid?
  end

  describe "Validations" do
    it "must have a username" do
      expect(user).must_respond_to :username

      new_user = User.new(username: nil)
      assert_not new_user.valid?
    end

  end
end
