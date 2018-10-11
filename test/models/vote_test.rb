require "test_helper"

describe Vote do
  describe 'validations' do
    before do
      @work = Work.create(
        title: 'test work',
        creator: 'test author',
        category: 'book',
        publication_year: 1988,
        description: 'description here'
      )
      @user = User.create(
        username: 'test user'
      )
      @vote = Vote.new(
        user_id: User.find_by(username: 'test user').id,
        work_id: Work.find_by(title: 'test work').id
      )
    end

    it 'is valid when user_id and work_id is a unique combination' do

      # puts "User: #{@vote.user_id} and Work: #{@vote.work.id}"

      expect(@vote.valid?).must_equal true
    end

    it 'is invalid when user_id and work_id is a non-unique combination' do
      new_vote = Vote.new(
        user_id: Vote.first.user_id,
        work_id: Vote.first.work_id
      )
      
      expect(new_vote.valid?).must_equal false
    end

  end



end
