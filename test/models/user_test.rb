require "test_helper"
require 'pry'

describe User do
  # let(:user) { User.new }

  before do
    @user1 = users(:house)
    @user2 = users(:jones)
    # binding.pry
  end

  #
  # has_many :votes
  #
  # validates :username, presence: true, uniqueness: true, allow_nil: true
  #

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


  #not sure why this test is true should be false based on model user realtionship

  # it "It is not valid when username is not unique" do
  #
  #   same_username = User.new(username: @user1.username)

  #   binding.pry
  #   expect(same_username).must_equal false
  #
  #
  # end


#not sure why this test is running, even though on website it does not allow it to be blank 
  # it "It is not valid when the username is blank" do
  #   blank_username = User.new()
  #   binding.pry
  #   expect(blank_username).must_equal false
  # end










end
