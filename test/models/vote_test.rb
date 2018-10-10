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
      expect(user).must_be_instance_of User
    end

    it 'belongs to a work' do
      # Arrange is done with let

      # Act
      work = vote.work

      # Assert
      expect(work).must_be_instance_of Work
    end
  end
end
