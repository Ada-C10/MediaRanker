require "test_helper"

describe Vote do
  let(:vote) { votes(:vote1) }

  it "must not be valid when created without user_id and work_id" do
    value(vote.valid?).must_equal true
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

  end

end


# belongs_to :user
# belongs_to :work
# #vote can only be created on the same work by the same user once aka   #each user can only upvote a work once
# validates :user_id, uniqueness: {scope: :work_id, message:"You can only vote once"}
