require "test_helper"

describe VotesController do
  it "should get new" do
    get votes_new_url
    value(response).must_be :success?
  end

  it "should get destroy" do
    get votes_destroy_url
    value(response).must_be :success?
  end

  it "should get upvote" do
    get votes_upvote_url
    value(response).must_be :success?
  end

  it "should get index" do
    get votes_index_url
    value(response).must_be :success?
  end

  it "should get show" do
    get votes_show_url
    value(response).must_be :success?
  end

  it "should get create" do
    get votes_create_url
    value(response).must_be :success?
  end

end
