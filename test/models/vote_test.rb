require "test_helper"

describe Vote do
  before do
    @vote = votes(:vote)
  end

  describe 'validations' do
    it "is valid with work and user" do
      expect(@vote.valid?).must_equal true
    end
    it "is invalid if user has already voted for work" do
      @error_vote = Vote.new(
        work: works(:harry_potter),
        user: users(:val))
      expect(@error_vote.valid?).must_equal false
      expect(@error_vote.errors.messages).must_include :work_id
    end
  end
  describe 'relations' do
    it 'responds to work method' do
      expect(@vote).must_respond_to :work
      expect(@vote.work.title).must_equal 'Harry Potter'
    end
    it 'responds to user method' do
      expect(@vote).must_respond_to :user
      expect(@vote.user.name).must_equal 'valgidzi'
    end
  end
end
