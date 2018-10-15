require "test_helper"

describe Vote do

  describe 'relations' do

    it "belongs to a work" do

      work = Work.first
      votes = work.votes

      expect(votes).must_respond_to :each

    end

    it "belongs to a user" do

      user = User.first
      votes = user.votes

      expect(votes).must_respond_to :each

    end
  end

end
