require "test_helper"

describe User do
  let(:user) { users(:hannah) }

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

    it 'can have many works through through' do
      user.works << Work.first
      works = user.works

      expect(user.works.length).must_be :>=, 0

      user.works.each do |work|
        expect(work).must_be_instance_of Work
      end
    end
  end

  describe 'validations' do
    it 'must have a username' do
      user.user_name = nil

      valid = user.valid?

      expect(valid).must_equal false
      expect(user.errors.messages).must_include :user_name
    end

    it 'must have a title with a min of 5 letters' do
      #arrange
      user.user_name = ''
      4.times do
        user.user_name += 'a'

        valid = user.valid?

        expect(valid).must_equal false
        expect(user.errors.messages).must_include :user_name
      end

    end

    it 'must be no longer than 20 characters for username' do
      user.user_name = 'kljsdfh99999999999khb3209843209834234'

      valid = user.valid?

      expect(valid).must_equal false
      expect(user.errors.messages).must_include :user_name
    end
  end
end
