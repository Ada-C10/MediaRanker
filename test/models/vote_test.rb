require "test_helper"

describe Vote do
  let(:vote) { Vote.new }

  it "must be for a valid category" do
    value(vote).must_be_kind_of :work
  end
  it 'has required fields' do
    fields = [:movie, :book, :album ]

    fields.each do |field|
      expect(vote).must_respond_to field
    end
  end
end
