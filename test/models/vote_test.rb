require "test_helper"

describe Vote do
  let(:vote) { votes(:vote_one) }

  it "must be valid" do
    result = vote.valid?
    expect(result).must_equal true
  end

  describe 'relations' do
    it "belongs to a user" do
      vote.user.must_equal users(:user_one)
    end
    it "belongs to work" do
      vote.work.must_equal works(:work_1)
    end

  end
end
