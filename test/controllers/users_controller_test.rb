require "test_helper"

describe UsersController do
  let(:user) { users(:marshall) }

  it "gets index" do
    get users_url
    value(response).must_be :success?
  end

  it "creates user" do
    expect {
      post users_url, params: { user: { name: 'a unique name' } }
    }.must_change "User.count"
  end

  it "shows user" do
    get user_url(user)
    value(response).must_be :success?
  end

end
