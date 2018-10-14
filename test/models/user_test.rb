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

    # binding.pry
    value(@user1).must_be :valid?
    value(@user2).must_be :valid?




  end




end
