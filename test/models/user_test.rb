require "test_helper"

describe User do
  describe 'User validations' do
    it "is valid with dashes, underscores, numbers, and letters" do
      valid_names = ["test_user", "test-user", "123testuser"]
      valid_names.each do |name|
        user = User.new(name: name)
        expect(user).must_be :valid?
      end
    end

    it 'is invalid with spaces, periods, and special characters' do
      invalid_names = ["test user", "test.user", "test!user"]
      invalid_names.each do |name|
        user = User.new(name: name)
        expect(user.valid?).must_equal false
        expect(user.errors.messages).must_include :name
      end
    end

    it 'is invalid unless name is unique (case-insensitive)' do
      another_user = User.new(name: "sTeVONniE")
      expect(another_user.valid?).must_equal false
      expect(another_user.errors.messages).must_include :name
    end

    it 'is invalid unless name length is within 6..20 characters' do
      user = User.new(name: nil)
      invalid_lengths = [0, 5, 21]
      invalid_lengths.each do |length|
        user.name = ("a" * length)
        expect(user.valid?).must_equal false
        expect(user.errors.messages).must_include :name
      end

      valid_lengths = [6, 20]
      valid_lengths.each do |length|
        user.name = ("a" * length)
        expect(user.valid?).must_equal true
      end
    end
   end

   describe 'User relations' do
     it 'can get votes with "votes"' do
       vote = Vote.create!(user_id: users(:stevonnie).id, work_id: works(:parable).id)
       expect(users(:stevonnie).votes.ids).must_equal [vote.id]
     end
   end
end
