require "test_helper"


describe Vote do
  let(:vote) { votes(:vote1)  }

  it "must be valid" do
    expect(vote).must_be :valid?
  end

  it 'has required fields' do
    fields = [:work_id, :user_id]

    fields.each do |field|
      expect(vote).must_respond_to field
    end
  end

  describe 'Relationships' do
    it 'belongs to a user' do
      # Arrange (done with let)

      # Act
      user = vote.user

      # Assert
      expect(user).must_be_instance_of User
      expect(user.id).must_equal vote.user_id
    end

    it 'belongs to a work' do
      # Arrange (done with let)

      # Act
      work = vote.work

      # Assert
      expect(work).must_be_instance_of Work
      expect(work.id).must_equal vote.work_id
    end
  end

  describe 'validations' do
    it 'must have a user_id' do
      # Arrange

      vote.user_id = nil

      # Act
      #valid = book.valid?
      valid = vote.save

      # Assert
      expect(valid).must_equal false
      expect(vote.errors.messages).must_include :user_id
      expect(vote.errors.messages[:user_id]).must_equal ["can't be blank"]
    end

    it 'must have a work_id' do
      # Arrange

      vote.work_id = nil

      # Act
      #valid = book.valid?
      valid = vote.save

      # Assert
      expect(valid).must_equal false
      expect(vote.errors.messages).must_include :work_id
      expect(vote.errors.messages[:work_id]).must_equal ["can't be blank"]
    end
  end

  describe "self.duplicated_votes" do
    it 'must return true when user vote for the same work more than once' do
      other_vote = Vote.new
      other_vote.user = vote.user
      other_vote.work = vote.work

      result = Vote.duplicated_votes(other_vote.user_id, other_vote.work_id)
      (result).must_equal true
    end

    it 'must return false when user vote for the work first time' do
      other_vote = Vote.new
      other_vote.user = vote.user
      other_vote.work = vote.work

      result2 = Vote.duplicated_votes(1, 1)
      expect(result2).must_equal false
    end
  end
end
