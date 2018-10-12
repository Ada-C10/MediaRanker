require "test_helper"

describe VotesController do
  it "should get new" do
    get votes_new_url
    value(response).must_be :success?
  end

  it "should get edit" do
    get votes_edit_url
    value(response).must_be :success?
  end

end
