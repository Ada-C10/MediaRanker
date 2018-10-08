require "test_helper"

describe User do

  describe 'Validation' do

    it 'invalid without a name' do
      user = User.first

      user.name = nil

      expect( user.valid? ).must_equal false

    end

    it 'is valid when name is present' do
      expect( User.first.valid? ).must_equal true
    end
  end

  describe 'Relations' do
    it 'can add a vote using method votes' do
      user = User.first
      work = Work.first
      vote = Vote.new(work: work)


      user.votes << vote
      expect( user.votes.first ).must_equal vote
    end
  end


end
