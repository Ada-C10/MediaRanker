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

    it "a user can only vote on the same work once" do

      v = Vote.first
      work = v.work
      user = v.user

      has_voted = Vote.already_voted?(work.id, user.id)

      expect(has_voted).must_equal true


    end


  end
end
