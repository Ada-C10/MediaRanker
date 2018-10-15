require "test_helper"

describe PagesController do
  it "should get index" do
    get pages_index_url
    value(response).must_be :success?
  end

end
