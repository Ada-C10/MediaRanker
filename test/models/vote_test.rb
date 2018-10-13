require "test_helper"

describe 'Vote' do
  describe 'relations' do
    describe 'work that belongs to a vote' do
      before do
        @user1 = users(:june)
        @work1 = works(:sound_of_music)
        @vote1 = Vote.create!(user_id: @user1.id, work_id: @work1.id)
      end

      it 'connects a work with a vote' do
        work_connected_to_vote = @vote1.work_id
        work_id = @work1.id
        expect(work_connected_to_vote).must_equal work_id
      end

      it 'connects a user with a vote' do
        user_connected_to_vote = @vote1.user_id
        user_id = @user1.id
        expect(user_connected_to_vote).must_equal user_id
      end
    end
  end
end
