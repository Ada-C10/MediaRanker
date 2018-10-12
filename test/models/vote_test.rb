require "test_helper"

describe Vote do

  it 'creates a new vote' do
    vote = Vote.create{:jazz}
    work = Work.create{:jazz}
    work.votes
    binding.pry

    expect(vote.valid?).must_equal true
  end

end
