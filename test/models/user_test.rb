require "test_helper"

describe User do
  let(:user) { users(:alice) }

  describe "Relationships" do
  end

  describe "Validations" do
    it "is valid when all fields are present" do
      expect(user).must_be :valid?
    end

    it "must have a name" do
      user.name = nil

      valid = user.valid?

      expect(valid).must_equal false
      expect(user.errors.messages).must_include :name
    end
  end

  describe "Custom Methods" do
  end
end
