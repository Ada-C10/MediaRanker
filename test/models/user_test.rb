require "test_helper"

describe User do
  let(:user) { users(:jackie) }

  it "must be valid" do
    value(user).must_be :valid?
  end

  it 'has required fields' do
    fields = [:username, :joined, :votes, :works]

    fields.each do |field|
      expect(user).must_respond_to field
    end
  end

  describe 'relationships' do
    it 'has many votes' do
      # Arrange is done with let

      # Act
      votes = user.votes

      # Assert
      expect(user).must_be_instance_of User

      expect(votes.length).must_be :>=, 1
      votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

    it 'has many works through votes' do
      # Arrange is done with let

      # Act
      works = user.works

      # Assert
      expect(user).must_be_instance_of User

      expect(works.length).must_be :>=, 1
      works.each do |work|
        expect(work).must_be_instance_of Work
      end
    end
  end

  describe 'validations' do
    it 'must have a username' do
      # Arrange
      user.username = nil

      # Act
      valid = user.valid? # run validations

      # Assert
      expect(valid).must_equal false
      expect(user.errors.messages).must_include :username
      expect(user.errors.messages[:username]).must_equal ["can't be blank"]

      # Rearrange
      user.username = "jackie"

      # Re-Act
      valid = user.valid? # run validations

      # Reassert
      expect(valid).must_equal true
    end

    it 'must have a joined date' do
      # Arrange
      user.joined = nil

      # Act
      valid = user.valid? # run validations

      # Assert
      expect(valid).must_equal false
      expect(user.errors.messages).must_include :joined
      expect(user.errors.messages[:joined]).must_equal ["can't be blank"]

      # Rearrange
      user.joined = "2018-10-10"

      # Re-Act
      valid = user.valid? # run validations

      # Reassert
      expect(valid).must_equal true
    end
  end

  #TODO custom method test
=begin
  def vote_date(work)
    return self.votes.find_by(work_id: work.id).date
  end
=end
end
