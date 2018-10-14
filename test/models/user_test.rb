require "test_helper"

describe User do
  let(:user) { User.new(
    name: 'test name',
    )
  }

  it "must be valid" do
    value(user).must_be :valid?
  end
end
