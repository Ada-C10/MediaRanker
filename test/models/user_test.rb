require "test_helper"

describe User do
  # VALIDATIONS TESTS
  describe 'validations' do

    it 'is not valid without a username' do
      user = users(:oreo)

      user.username = nil

      expect( user ).must_be :invalid?
    end

    it 'is valid when all fields are present' do
      user = users(:muffin)

      expect( user ).must_be :valid?
    end

  end


  # RELATIONS TESTS
  describe 'relations' do
    
    it 'must relate to a vote' do
      user = users(:chips)

      expect( user ).must_respond_to :votes
    end

    it 'returns an array of votes when using the votes method call' do
      user = users(:oreo)

      votes = user.votes

      expect( votes.count ).must_equal 3
      expect( votes.first ).must_be_kind_of Vote
    end

    it 'returns an empty array if there are no votes for the user when using the votes method call' do
      user = users(:popcorn)

      votes = user.votes

      expect( votes.first ).must_equal nil
      expect( votes.count ).must_equal 0
    end


  end

end
