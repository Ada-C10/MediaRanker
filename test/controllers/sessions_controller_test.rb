require "test_helper"

describe SessionsController do
  it "should get new" do
    get sessions_new_url
    value(response).must_be :success?
  end

  it "should get index" do
    get sessions_index_url
    value(response).must_be :success?
  end

  it "should get destroy" do
    get sessions_destroy_url
    value(response).must_be :success?
  end

end
