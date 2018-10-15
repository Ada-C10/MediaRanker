require "test_helper"

describe Vote do

  describe "validations" do
    let(:vote) { votes(:one) }
    let(:vote_two) { votes(:two) }
    let(:vote_three) { votes(:three) }
    let(:work) { works(:the_big_lebowski) }

    it "must be valid" do
      value(vote).must_be :valid?
    end

    it 'is invalid without a work_id' do
      # Arrange
      vote.work_id = nil
      # Act
      result = vote.valid?
      # Assert
      expect(result).must_equal false
    end

    it 'only one vote per work per user is valid' do
      # Arrange
      vote_three.work = work
      # Act
      result = vote_three.valid?
      # Assert
      expect(result).must_equal false
    end

  end

  describe "custom methods" do

  end

  describe "relationships" do
    let(:vote) { votes(:one) }

    it 'belongs to an user' do
      user = vote.user
      # Assert
      expect(user).must_be_instance_of User
      expect(user.id).must_equal vote.user_id
    end

    it 'belongs to a work' do
      work = vote.work
      # Assert
      expect(work).must_be_instance_of Work
      expect(work.id).must_equal vote.work_id
    end
  end

end
