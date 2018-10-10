require "test_helper"

describe User do
  let(:user) { users(:jackie) }
  let(:work) { works(:hp) }

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

  describe 'vote_date' do
    it 'must return the date the user voted on the designated work' do
      # Arrange in fixture
      # Act
      date = user.vote_date(work)

      # Assert
      expect(date).must_equal Date.parse('2018-10-08')
    end

    it 'returns nil when the user has not voted on that work' do
      date = user.vote_date(works(:interstellar))

      # Assert
      expect(date).must_be_nil
    end
  end

  describe 'vote_count' do
    it 'must return the total number of votes a user has made' do
      # Arrange in fixture
      # Act
      count = user.vote_count

      # Assert
      expect(count).must_equal 2
    end

    it 'returns 0 when the user has not voted on anything' do
      # Arrange
      new_user = users(:dan)

      # Act
      count = new_user.vote_count

      # Assert
      expect(count).must_equal 0
    end
  end
end
