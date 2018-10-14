require "test_helper"

describe User do
  let(:one) { users(:one) }

  it "must be valid" do
    expect(one.valid?).must_equal true
  end

  it "must have a name" do
    one.name = nil
    expect(one.valid?).must_equal false
    expect(one.errors.messages).must_include :name
  end

end
