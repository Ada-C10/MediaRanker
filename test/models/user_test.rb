require "test_helper"

describe User do
  let(:user) { users(:alice) }

  describe "Relationships" do
    it "can have many votes" do
      expect(user.votes.count).must_equal 3
    end

    it "can have 0 votes" do
      other_user = User.new(name: "Joyce")
      expect(other_user.votes.count).must_equal 0
    end

    it "can access works through votes" do
      expect(user.works.length).must_be :>=, 0

      user.works.each do |work|
        expect(work).must_be_instance_of Work
      end
    end

    it "has an accurate count of works when some are destroyed" do
      votes(:three).destroy
      works(:park).destroy
      expect(user.works.count).must_equal 2
    end
  end

  describe "Validations" do
    it "is valid when all fields are present" do
      expect(user).must_be :valid?
    end

    it "must have a name" do
      user.name = nil

      valid = user.valid?

      expect(valid).must_equal false
      expect(user.errors.messages).must_include :name
    end

    it "must have a join date" do
      user.join_date = nil

      valid = user.valid?

      expect(valid).must_equal false
      expect(user.errors.messages).must_include :join_date
    end
  end
end
