require "test_helper"

describe Vote do
  let(:vote) { votes :one }
  # binding.pry
  it 'must be valid' do
    expect(vote).must_be :valid?
  end
end
