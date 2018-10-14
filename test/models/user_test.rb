require "test_helper"

describe User do
  describe 'relations' do
    it 'can set the user id through new vote' do
      # Create two models
      @user = User.create!(username: 'puppy')
      @vote = Vote.new

      # Make the models relate to one another
      @vote.user_id = @user.id

      # author_id should have changed accordingly
      expect(@vote.user_id).must_equal @user.id
    end

    it "has a vote" do
      user = users(:karis)
      user.votes.must_include votes(:one)
    end

    it "can set the work id in vote through work" do
      user = users(:harry)
      vote = votes(:two)
      user.votes << vote

      user.votes.first.id.must_equal votes(:two).id
    end
  end
end
