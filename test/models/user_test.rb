require "test_helper"

describe User do
  describe "validations" do
    let(:user) { users(:jane) }
    let(:user_two) { users(:ken) }

    it "must be valid" do
      value(user).must_be :valid?
    end

    it 'is invalid without a name' do
      # Arrange
      user.name = nil
      # Act
      result = user.valid?
      # Assert
      expect(result).must_equal false
    end

    it 'each user name must be unique' do
      # Arrange
      user_two.name = user.name
      # Act
      result = user_two.valid?
      # Assert
      expect(result).must_equal false
    end

    it 'a user name must at least two characters' do
      # Arrange
      user.name = "t"
      # Act
      result = user.valid?
      # Assert
      expect(result).must_equal false
    end

    it "a user name can't be more than fifty characters" do
      # Arrange
      user.name = "janejanejanejanejanejanejanejanejanejanejanejanejane"
      # Act
      result = user.valid?
      # Assert
      expect(result).must_equal false
    end

  end

  describe "custom methods" do

  end

  describe "relationships" do
    let(:user) { users(:jane) }

    it 'can have many votes' do
      votes = user.votes
      expect(votes.length).must_be :>=, 1
      votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

  end

end
