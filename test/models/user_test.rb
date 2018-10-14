require "test_helper"

describe User do
  let(:user) { User.new }

  it "must be valid" do
    value(user).must_be :valid?
  end

  it 'has required fields' do
    fields = [:handle]

    fields.each do |field|
      expect(work).must_respond_to field
    end
  end 
end
