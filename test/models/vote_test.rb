require "test_helper"

describe Vote do
  let (:jazz) {users(:jazz)}
  let (:vote1) {votes(:vote1)}
  let (:book) {works(:book)}
  let (:album) {works(:album)}

  it 'creates a valid vote' do
    expect(vote1.valid?).must_equal true
  end

  it "adds a new vote to work" do

    expect(Vote.all.length).must_equal 2
    new_vote = Vote.create(user: jazz, work: album )

    expect(Vote.all.length).must_equal 3
  end

  describe 'validations' do

    it "is an invalid vote without a username" do
      new_vote = Vote.create(work: book)
      expect(new_vote.valid?).must_equal false
      expect(new_vote.errors.messages).must_equal :user=>["must exist"]
    end

    it "is invalid without a work id" do
      new_vote = Vote.create(user:jazz)
      expect(new_vote.valid?).must_equal false
      expect(new_vote.errors.messages).must_equal :work=>["must exist"]
    end

    it "is invalid with more than one vote" do
      new_vote = Vote.create(user: jazz, work: book)
      expect(Vote.all.length).must_equal 2
      expect(new_vote.valid?).must_equal false
      expect(new_vote.errors.messages).must_equal :work_id=>["You can only vote once for this work"]
    end



  end

end
