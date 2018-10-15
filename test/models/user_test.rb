require "test_helper"

describe User do
  let(:user) { users(:leanne) }

  it "must be valid" do
    value(user).must_be :valid?
  end

  it 'has required fields' do
    fields = [:handle]

    fields.each do |field|
      expect(user).must_respond_to field
    end
  end

  it 'requires a unique handle' do
    other_user = users(:leanne)
    other_user.handle = user.handle

    valid = other_user.valid?

    expect(valid).must_equal false
    expect(other_user.errors.messages).must_include :handle
  end
end
