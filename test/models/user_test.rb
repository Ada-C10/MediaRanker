require "test_helper"

describe User do
  let(:user) { users(:cassy) }
  before do
    @work = Work.first
  end
  describe 'validations' do
      # Does it pass with all fields?
      it 'is valid when all fields are present' do
        #Act
        result = user.valid?

        # Assert
        expect(result).must_equal true
      end
      # Does it fail if name is missing?
      it 'is invalid without a name' do
        # Arrange
        user.name = nil

        # Act
        result = user.valid?

        #Assert
        expect(result).must_equal false
        expect(user.errors.messages).must_include :name

      end

      # Does it fail if there's a duplicate name?
      it 'requires a unique name' do
        other_user = users(:jane)
        other_user.name = user.name
        valid = other_user.valid?
        expect(valid).must_equal false
        expect(other_user.errors.messages).must_include :name
      end

  end

  describe 'relations' do
    it 'can have many votes' do
      # Adding a vote
      user.votes <<
        Vote.new(
            date_created: Date.today,
            work_id: @work.id
        )

      votes = user.votes

      expect(votes.length).must_be :>=, 1
      votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe 'custom methods' do

  end
end
