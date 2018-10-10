require "test_helper"

describe MainController do
  it "should get index" do
    get main_index_url
    value(response).must_be :success?
  end

  it "should get show" do
    get main_show_url
    value(response).must_be :success?
  end

end
