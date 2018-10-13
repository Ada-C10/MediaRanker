require "test_helper"

describe Vote do
let (:jazz) {users(:jazz)}
let (:vote1) {votes(:vote1)}
let (:book) {works(:book)}
let (:album) {works(:album)}

  it 'creates a valid vote' do
    expect(vote1.valid?).must_equal true
  end

  it "creates adds a vote to work" do

    expect(Vote.all.length).must_equal 2
    new_vote = Vote.create(user: jazz, work: album )

    expect(Vote.all.length).must_equal 3
  end

end
