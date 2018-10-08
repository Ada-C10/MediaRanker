require "test_helper"

describe Work do
  describe 'Validation' do

    it 'invalid without a title' do
      work = Work.first
      work.title = nil
      expect( work.valid? ).must_equal false
    end

    it 'invalid with a nonunique title' do
      work = Work.new(title: Work.first.title)
      expect( work.valid? ).must_equal false
    end

    it 'is valid when title is present and unique' do
      work = Work.new(title: 'test title')
      expect( work.valid? ).must_equal true
    end
  end

  describe 'Relations' do

    it 'can add a vote using method votes' do
      work = Work.first
      user = User.first
      vote = Vote.new(user: user)

      work.votes << vote
      expect( work.votes.first ).must_equal vote
    end
  end
end
