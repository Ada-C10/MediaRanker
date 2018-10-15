require "test_helper"

describe UsersController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end
  describe "show" do
    it "should respond with success for showing an existing book" do
      id = users(:one)

      get user_path(id)

      must_respond_with :success
    end

    it "should respond with not found for showing a non-existant book" do
      #ARRANGE

    end
  end
end
