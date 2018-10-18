require "test_helper"
require 'pry'
describe Vote do
  let(:vote) { votes(:vote1) }
  let(:vote2) { votes(:vote2) }


  it "must be valid" do
    value(vote).must_be :valid?
  end

  it 'has required fields' do
    fields = [:user_id, :work_id]

    fields.each do |field|
      expect(vote).must_respond_to field
    end
  end

  describe 'Validations' do

    it 'must not be valid when created without a work_id' do
      #arrange
      vote.work_id = nil

      #act
      valid = vote.save

      #assert
      expect(valid).must_equal false
    end

    it 'must not be valid when created without a user_id' do
      #arrange
      vote.user_id = nil

      #act
      valid = vote.save

      #assert
      expect(valid).must_equal false
    end

    describe 'Relationships' do

      it 'must be associated with only one user_id (aka each user can only vote on a work once)' do
        #arrange
        vote.user_id = "user1"

        #act
        vote.save
        vote.user_id = "user1"
        valid = vote.save

        #assert
        expect(valid).must_equal false

      end

      it 'must be associated with only one work_id ' do
        #arrange
        vote.work_id = "work1"

        #act
        vote.save
        vote.work_id = "work1"
        valid = vote.save

        #assert
        expect(valid).must_equal false

      end
    end

  end
end


# validates :user_id, uniqueness: {scope: :work_id, message:"You can only vote once"}
