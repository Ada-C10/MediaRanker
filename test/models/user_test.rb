require "test_helper"

describe User do
  # let(:user) { User.new }

  before do
    @user1 = users(:house)
    @user2 = users(:jones)
    # binding.pry
  end

  it "must be valid" do
    value(@user1).must_be :valid?
  end


end
