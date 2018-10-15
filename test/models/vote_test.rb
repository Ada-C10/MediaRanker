require "test_helper"

require "pry"
describe Vote do
  describe 'relations' do
    before do
      work = works(:book1)
      user = users(:jim)
      vote = votes(:one)
    end
    it "belongs to a user " do
      before do
        work = works(:book1)
        user = users(:jim)
        vote = votes(:one)
      end
      user.vote.must_equal votes(:one)
    end

    it "belongs to a work" do
      work.vote.must_equal works(:one)
    end
  end
end
