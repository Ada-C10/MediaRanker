require "test_helper"

describe VotesController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  describe Vote do
    describe 'validations' do
      before do
        # Arrange
        user = User.first
        work = Work.first
        @vote = Vote.new(user_id: user.id, work_id: work.id)
      end

      it 'is valid when all fields are present' do
        # Act
        result = @vote.valid?

        # Assert
        expect(result).must_equal true
      end

      it 'is invalid when all user_id field not present' do
        @vote.user_id = nil

        result = @vote.valid?

        expect(result).must_equal false
      end

      it 'is invalid when work_id field not present' do
        @vote.work_id = nil

        result = @vote.valid?

        expect(result).must_equal false
      end

    end
  end
end
