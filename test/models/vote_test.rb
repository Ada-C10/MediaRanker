require "test_helper"

describe Vote do
  let(:vote) { votes :one }
  # binding.pry
  it 'must be valid' do
    expect(vote).must_be :valid?
  end

  describe 'validations' do
    it 'must have a user' do
      vote.user_id = nil
      # validations .valid? will run all validations
      valid = vote.valid?
      # assert
      expect(valid).must_equal false
      expect(vote.errors.messages).must_include :user_id
    end

    it 'must have a work' do
      vote.work_id = nil
      # validations .valid? will run all validations
      valid = vote.valid?
      # assert
      expect(valid).must_equal false
      expect(vote.errors.messages).must_include :work_id
    end
  end
end


