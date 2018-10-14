require "test_helper"
require 'pry'

describe User do
  # let(:user) { User.new }

  before do
    @user1 = users(:house)
    @user2 = users(:jones)
  end

  it "must be valid" do
    value(@user1).must_be :valid?
  end


  it "It is valid when user has many  votes" do

    @work1 = Work.new(title: "The name of the wind")

    @work1 = Work.new(title: "Ruby on Rails")

    user_vote1 = Vote.new(user_id: @user1.id, work_id: @work1.id)

    user_vote2 = Vote.new(user_id: @user1.id, work_id: @work1.id)

    value(@user1).must_be :valid?
    value(@user2).must_be :valid?

  end


  it "It is not valid when username is not unique" do

    same_username = User.new(username: @user1.username)
    same_username.save

    is_valid = same_username.valid?

    expect(is_valid).must_equal false


  end


  it "It is not valid when the username is blank" do
    blank_username = User.new()

    blank_username.save

    is_valid = blank_username.valid?

    expect(is_valid).must_equal false

  end










end
