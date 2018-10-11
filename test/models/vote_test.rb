require "test_helper"

describe Vote do
  let(:vote) { votes(:vote_one) }

  it "must be valid" do
    value(vote).must_be :valid?
  end

  it 'has required fields' do
    fields = [:date, :work, :user]

    fields.each do |field|
      expect(vote).must_respond_to field
    end
  end

  describe 'relationships' do
    it 'belongs to a user' do
      # Arrange is done with let

      # Act
      user = vote.user

      # Assert
      expect(vote).must_be_instance_of Vote
      expect(user).must_be_instance_of User
    end

    it 'belongs to a work' do
      # Arrange is done with let

      # Act
      work = vote.work

      # Assert
      expect(vote).must_be_instance_of Vote
      expect(work).must_be_instance_of Work
    end
  end

  describe 'validations' do
    it 'must have a user' do
      # Arrange
      vote.user = nil

      # Act
      valid = vote.valid? # run validations

      # Assert
      expect(valid).must_equal false
      expect(vote.errors.messages).must_include :user
      expect(vote.errors.messages[:user]).must_equal ["must exist", "can't be blank"]

      # Rearrange
      vote.user = users(:jackie)

      # Re-Act
      valid = vote.valid? # run validations

      # Reassert
      expect(valid).must_equal true
    end

    it 'must have a work' do
      # Arrange
      vote.work = nil

      # Act
      valid = vote.valid? # run validations

      # Assert
      expect(valid).must_equal false
      expect(vote.errors.messages).must_include :work
      expect(vote.errors.messages[:work]).must_equal ["must exist", "can't be blank"]

      # Rearrange
      vote.work = works(:hp)

      # Re-Act
      valid = vote.valid? # run validations

      # Reassert
      expect(valid).must_equal true
    end

    it 'must have a date' do
      # Arrange
      vote.date = nil

      # Act
      valid = vote.valid? # run validations

      # Assert
      expect(valid).must_equal false
      expect(vote.errors.messages).must_include :date
      expect(vote.errors.messages[:date]).must_equal ["can't be blank"]

      # Rearrange
      vote.date = Date.today

      # Re-Act
      valid = vote.valid? # run validations

      # Reassert
      expect(valid).must_equal true
    end
  end
end
