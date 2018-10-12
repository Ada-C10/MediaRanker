require "test_helper"

describe Vote do
  let(:vote) { votes(:harry_votes) }

  it "must be valid" do
    expect(vote).must_be :valid?
  end

  describe 'relationships' do
    it 'belongs to an user' do
      user = vote.user

      expect(user).must_be_instance_of User
      expect(user.id).must_equal vote.user_id
    end

    it 'belongs to a work' do
      work = vote.work

      expect(work).must_be_instance_of Work
      expect(work.id).must_equal vote.work_id
    end
  end

  describe 'validations' do
    it "must be an integer for quantity" do
      vote.quantity = 'seaweed'

      valid = vote.valid?

      expect(valid).must_equal false
      expect(vote.errors.messages).must_include :quantity
    end

    it 'must have a vote count greater than 0' do
      vote.quantity = 1

      valid = vote.valid?

      expect(valid).must_equal false
      expect(vote.errors.messages).must_include :quantity

    end
  end
end
