require "test_helper"

describe Vote do
  let(:vote) { votes(:vote1) }

  it "must be valid" do
    value(vote).must_be :valid?
  end


  it 'has required fields' do
    fields = [:work_id, :user_id]

    fields.each do |field|
      expect(work).must_respond_to field
    end
  end


  describe 'Relationships' do
    it 'belongs to a user' do

      user = vote.user

      # Assert
      expect(user).must_be_instance_of User
      expect(user.id).must_equal vote.user_id
    end

    end
  end
