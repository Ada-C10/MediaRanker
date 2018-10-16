require "test_helper"

describe User do
  describe 'validations' do
    before do
      @user = User.new(username: 'test')
    end

    it 'is invalid without a username' do
      @user.username = nil

      result = @user.valid?

      expect(result).must_equal false
      expect( @user.errors.messages ).must_include :username

    end

    it 'is invalid with a non-unique username' do
      @user.username = User.first.username
      result = @user.valid?
      expect(result).must_equal false
      expect( @user.errors.messages ).must_include :username
    end
  end
  describe User do
    let(:user) { users(:naheed) }
    it "must be valid" do
      expect(user).must_be :valid?
    end
    describe 'Relationships' do
      it 'can have many votes' do
        user.votes << Vote.first
        votes = user.votes
        expect(votes.length).must_be :>=, 0
        votes.each do |vote|
          expect(vote).must_be_instance_of Vote
        end
      end
    end
  end
end
