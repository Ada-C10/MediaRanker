require "test_helper"

describe User do

  describe 'relations' do
    it 'a user can have many votes' do
      user1 = users(:june)
      work1 = works(:sound_of_music)
      work2 = works(:green_eggs)
      vote1 = Vote.create!(user_id: user1.id, work_id: work1.id)
      vote2 = Vote.create!(user_id: user1.id, work_id: work2.id)
      votes = Vote.where(user_id: user1.id)

      expect(votes.count).must_equal 2
    end
  end

  describe 'validations' do
    # note to self: .valid? checks against yaml file
    it 'is a valid user if the username is present and unique' do
      new_user = User.new(username: "toby")
      is_valid = new_user.valid?
      expect(is_valid).must_equal true
    end

    it 'is not a valid user if the username is absent' do
      new_user = User.new
      is_valid = new_user.valid?
      expect(is_valid).must_equal false
    end

    it 'is not a valid user if the username is present but not unique' do
      new_user = User.new(username: "june")
      is_valid = new_user.valid?
      expect(is_valid).must_equal false
    end

  end

  describe 'custom methods' do


  end

end
