require "test_helper"

describe User do
  let(:user) { User.new }

  it "must be valid" do
    value(user).must_be :valid?
  end

  describe 'user_list' do
    it 'should return an array' do
      # Act
      users = User.work_list

      # Assert
      expect(users).must_be_instance_of Array

      users.each do |user_array|
        current_user = User.find(user_array[1])
        user_name = user_array[0]
        expect(users_name).must_equal current_user.username
      end
    end

    it 'should return an empty array when there are no users' do
      # Act
      User.all.each do |user|
        user.votes.each do |vote|
          vote.destroy
        end

        user.destroy
      end
      users = User.user_list

      # Assert
      expect(users).must_be_instance_of Array
      expect(users.length).must_equal 0
    end
  end

  describe "Presence of required attributes" do
    #arrange
    it "has required fields" do #act
      fields = [:username, :join_date]

      fields.each do |field| #assert
        expect(work).must_respond_to field
      end
    end

  describe 'validations' do

    it "requires a unique username" do
        #Arrange
        new_user = User.new username: user.username
        #Act
        new_work.valid?
        #Assert
        expect(new_user).must_equal false
        expect(user_work.errors.messages).must_include :username
      end
    end

  describe "Relationships" do #user has many votes
    it "can have many votes"
      #Arrange done with let

      #Act
      users << Vote.first
      votes = user.votes

      #Assert
      expect(votes).must_equal :>=, 1
      votes.each do |vote|
        expect(vote).must_be_instance of Vote
      end
    end 


end
