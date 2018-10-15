require "test_helper"

describe User do
  # let(:user) { User.new }
  #
  # it "must be valid" do
  #   value(user).must_be :valid?
  before do
    @user = User.new(user_name: 'test user')
  end

  it 'is invalid without a username' do
    @user.user_name = nil
    expect(@user.valid?).must_equal false
  end

  it 'is valid when username is present' do
    is_valid = @user.valid?
    expect(is_valid).must_equal true
  end

  it 'is valid if username is unique' do
    @user.user_name = User.first.user_name
    expect(@user.valid?).must_equal false
  end
end
