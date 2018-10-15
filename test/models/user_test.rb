require "test_helper"

describe User do
  let(:user) { users(:user3) }

  describe 'relations' do
    it 'has votes' do
      user.must_respond_to :votes
      expect(user.votes.first).must_be_kind_of Vote
    end
  end

  describe 'validations' do
    it "is valid when username is present and unique" do
      valid = user.valid?
      expect(valid).must_equal true

    end

    it 'is invalid without a username' do
      user.username = nil

      is_valid = user.valid?

      expect(is_valid).must_equal false
      expect(user.errors.messages).must_include :username
    end

    it "won't save if username is a duplicate" do
      new_user = User.new(username: users(:user3).username)
      valid = new_user.valid?
      expect(valid).must_equal false

    end
  end

  describe 'count votes (inherited)' do

    it 'accurately counts work votes' do
      low = works(:album1)
      high = works(:movie2)

      expect(low.count_votes).must_equal 1
      expect(high.count_votes).must_equal 2

    end
  end
end
