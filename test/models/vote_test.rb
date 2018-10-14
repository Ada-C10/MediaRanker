require "test_helper"
require 'pp'

describe Vote do
  describe 'relations' do
    it "has a work" do
      v = Vote.first
      work = v.work
      expect(work).must_be_instance_of Work
    end

    it "has a user" do
      v = Vote.first
      user = v.user
      expect(user).must_be_instance_of User
    end
  end
end
