require "test_helper"

describe User do
  describe "Validations" do
    let(:user) { User.new }

    it "must be invalid when fields are left blank" do
      value(user.valid?).must_equal false
    end

    it "is valid when username is provided" do
      user1 = users(:user1)

      value(user1.valid?).must_equal true
    end

    it "is invalid if the username is not unique" do
      user1 = users(:user1)
      user2 = User.create(username: "Vinnie")

      value(user1.valid?).must_equal true
      value(user2.valid?).must_equal false
    end

    it "is invalid if the username is not between 5 and 20 characters" do
      user1 = User.create(username: "ksaksadkjfalladfkjafdlajfkasdlkjfjasdlfkjadslfjk")
      user2 = User.create(username: "")

      value(user1.errors.messages).must_include :username
      value(user2.errors.messages).must_include :username
    end
  end

  describe 'Relationships' do
      it 'can have 0 or many votes' do
        user1 = users(:user1)
        vote = votes(:vote1)
        user2 = users(:user2)

        expect(user1.votes.length).must_be :>=, 1
        expect(user2.votes.length).must_be :>=, 0
        expect(user1.votes.first).must_be_instance_of Vote
      end
  end
end
