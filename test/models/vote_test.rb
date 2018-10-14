require "test_helper"

describe Vote do

  # VALIDATIONS TESTS
  describe 'validations' do

    it 'is not valid without a user' do
      vote = votes(:vote_one)

      vote.user = nil

      expect( vote ).must_be :invalid?
    end

    it 'is not valid without a work' do
      vote = votes(:vote_two)

      vote.work = nil

      expect( vote ).must_be :invalid?
    end

    it 'is valid when all fields are present' do
      vote = votes(:vote_three)

      expect( vote ).must_be :valid?
    end

    it 'is not valid when a user_id is not unique for the same work' do
      first_vote = votes(:vote_one)
      second_vote = votes(:vote_two)

      second_vote.user = first_vote.user

      expect( second_vote ).must_be :invalid?
    end

    it 'is valid when a user_id is unique for votes for the same work' do
      first_vote = votes(:vote_one)
      second_vote = votes(:vote_three)

      expect( second_vote ).must_be :valid?
    end
  end


  # RELATIONS TESTS
  describe 'relations' do

    it 'must relate to a work' do
      vote = votes(:vote_five)

      expect( vote ).must_respond_to :work
      expect( vote.work ).must_equal works(:greys)
    end

    it 'must relate to a user' do
      vote = votes(:vote_five)

      expect( vote ).must_respond_to :user
      expect( vote.user ).must_equal users(:oreo)
    end

    it 'can set the work' do
      vote = Vote.new(user: users(:cheetos))
      vote.work = works(:titanic)

      expect ( vote.work_id ).must_equal works(:titanic).id
    end

    it 'can set the user' do
      vote = Vote.new(work: works(:twix))
      vote.user = users(:burger)

      expect( vote.user_id ).must_equal users(:burger).id
    end

  end



end
