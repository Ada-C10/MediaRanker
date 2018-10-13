require "test_helper"

describe Vote do
  before do
    @vote = votes(:one)
  end
  describe 'Validations' do
    it 'valid when user and work ids are present' do
      is_valid = @vote.valid?
      expect(is_valid).must_equal true
    end

    it 'invalid without a user' do
      @vote.user = nil
      is_valid = @vote.valid?
      expect(is_valid).must_equal false
    end

    it 'invalid without a work' do
      @vote.work = nil
      is_valid = @vote.valid?
      expect(is_valid).must_equal false
    end
    it 'is valid if for work to have the same work and user' do
      vote = Vote.new(work: @vote.work, user:@vote.user)
      is_valid = vote.valid?
      expect(is_valid).must_equal false
    end
  end

  describe 'relations' do
    it 'has a relation to work' do
      work = @vote.work
      expect(work).must_equal works(:one_work)
    end

    it 'has a relation to user' do
      user = @vote.user
      expect(user).must_equal users(:one_user)
    end
  end
end
