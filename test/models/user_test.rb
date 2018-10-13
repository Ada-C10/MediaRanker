require "test_helper"

describe User do
  describe 'User validations' do
     before do
       @user = User.new(name: 'testname')
     end

     it 'is valid when all fields are present' do
       expect(@user.valid?).must_equal true
     end

    it 'is invalid unless name is unique (case-insensitive)' do
      @user.save!
      another_user = User.new(name: 'tEStnAmE')
      expect(another_user.valid?).must_equal false
      expect(another_user.errors.messages).must_include :name
    end

    it 'is invalid unless name length is within 6..20 characters' do
      @user.name = ("a" * 5)
      expect(@user.valid?).must_equal false
      expect(@user.errors.messages).must_include :name

      @user.name = ("a" * 6)
      expect(@user.valid?).must_equal true

      @user.name = ("a" * 20)
      expect(@user.valid?).must_equal true

      @user.name = ("a" * 21)
      expect(@user.valid?).must_equal false
      expect(@user.errors.messages).must_include :name
    end

    it 'is invalid unless name is only letters, numbers, dashes, and underscores' do
      @user.name = ("123testuser")
      expect(@user.valid?).must_equal true

      @user.name = ("test-user")
      expect(@user.valid?).must_equal true

      @user.name = ("test_user")
      expect(@user.valid?).must_equal true

      @user.name = ("test.user")
      expect(@user.valid?).must_equal false
      expect(@user.errors.messages).must_include :name

      @user.name = ("test!user")
      expect(@user.valid?).must_equal false
      expect(@user.errors.messages).must_include :name
    end
   end

   describe 'User relations' do
     before do
       @user = User.create!(name: 'test_name')
     end

     it 'can get votes with "votes"' do
       work = Work.create!(title: 'test book', category: :album,
         creator: 'test creator', publication: 1700, description: nil)
       vote = Vote.create!(user_id: @user.id, work_id: work.id)
       expect(@user.votes.ids).must_equal [vote.id]
     end
   end
end
