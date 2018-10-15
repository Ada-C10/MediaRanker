require "test_helper"

#does it upvote?
#does it downvoate?
#does it allow non-user to vote?
#does it allow user to vote twice?


describe Vote do
  let(:vote) { votes(:vote1) }

  it "must be valid" do
    value(vote).must_be :valid?
  end

  it 'has required fields' do
    fields = [:user_id, :work_id]

    fields.each do |field|
      expect(vote).must_respond_to field
    end
  end

  describe 'validations' do

    it 'requires a unique user id' do
      #other_book = book.clone
      other_vote = votes(:vote2)
      other_vote.user_id = vote.user_id

      valid = other_vote.valid?

      expect(valid).must_equal false
      expect(other_vote.errors.messages).must_include :user_id
    end
  end

  it 'can have multiple user ids per work id' do
    #other_book = book.clone
    vote = votes(:vote3)
    other_vote = votes(:vote2)
    other_vote.work_id = vote.work_id

    valid = other_vote.valid?

    expect(valid).must_equal true
  end
end
