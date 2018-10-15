require "test_helper"
require "pry"

describe Vote do

  describe "relations" do
    it "belongs to a user" do
      user = users(:jim)
      user.votes.must_include votes(:one)
    end

    it "belongs to a work" do
      work = works(:book1)
      work.votes.must_include votes(:one)
    end
  end

end
