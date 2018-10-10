require "test_helper"

describe User do
  let(:user) { users(:jessie) }

  it "must be valid" do
    value(user).must_be :valid?
  end

  it 'has required fields' do
    field = [:name].first
    expect(user).must_respond_to field
  end

  describe 'Relationships' do
    it 'can have many votes' do

      user.votes << Vote.first
      votes = user.votes

      expect(votes.length).must_be :>=, 1
      votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe 'validations' do
    it 'must have a name' do

      user.name = nil

      valid = user.save

      expect(valid).must_equal false
      expect(user.errors.messages).must_include :name
      expect(user.errors.messages[:name]).must_equal ["can't be blank"]
    end


    it 'requires a unique name' do

      other_user = User.new
      other_user.name = user.name

      valid = other_user.valid?

      expect(valid).must_equal false
      expect(other_user.errors.messages).must_include :name
    end

  end
end
