require "test_helper"

describe User do
  let(:user) { users(:user1) }

  it "must be valid" do
    value(user).must_be :valid?
  end


  describe 'Validations' do

    it 'must not be valid when created without a name' do
      #arrange
      user = User.new

      #act
      valid = user.save

      #assert
      expect(valid).must_equal false
    end
  end

  describe 'Relationships' do
    it 'has a list of votes' do
      user.must_respond_to :votes

      user.votes.each do |vote|
        vote.must_be_kind_of Vote
      end
    end

    it 'has a list of works through votes' do
      user.votes.each do |vote|
        vote.must_respond_to :work_id 
      end
    end


  end
end
