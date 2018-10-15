require "test_helper"

describe User do

  # describe 'relations' do
  #   it 'a vote can be set through the method work' do
  #     vote = Vote.create!
  #     work = Work.new()
  #
  #     work.vote = vote
  #
  #     expect(vote.work).must_equal work
  #     epect(vote.work_id).must_equal work_id
  #   end
  # end

  describe 'Validations' do
    before do
      @user = User.first
    end
    it 'is valid when username is present' do

      is_valid = @user.valid?

      expect(is_valid).must_equal true
    end

    it 'is invalid without a username' do
      @user.username = nil

      is_valid = @user.valid?

      expect(is_valid).must_equal false
      expect(@user.errors.messages).must_include :username
    end
  end
end
