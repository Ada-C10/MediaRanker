require "test_helper"

describe Vote do
  describe 'Relations' do
    before do
      @user = User.first
      @work = Work.first
    end


    it 'can add a user using method user' do
      vote = Vote.new(work: @work)

      vote.user = @user
      expect( vote.user ).must_equal @user
    end

    it 'can add a work using method work' do
      vote = Vote.new(user: @user)
      vote.work = @work
      expect( vote.work ).must_equal @work
    end

  end
end
