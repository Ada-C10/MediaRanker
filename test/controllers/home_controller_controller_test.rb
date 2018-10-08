require "test_helper"

describe HomeControllerController do
  it "should get index" do
    get home_controller_index_url
    value(response).must_be :success?
  end

end
