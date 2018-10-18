require "test_helper"

describe Vote do
  let(:vote) { Vote.new }

  it "must be valid" do
    value(vote).must_be :valid?
  end

  it 'has required fields' do
    fields = [:work_id, :user_id, :vote_time]

    fields.each do |field|
      expect(book).must_respond_to field
    end
  end

  describe 'Relationships' do
    it 'belongs to a work' do
      # Arrange (done with let)

      #Act
      work = vote.work #a vote belonging to a work, work_id

      #assert
      expect(work).must_be_instance_of Work
      expect(work.id).must_equal vote.work_id
    end


    it 'belongs to a user' do
      # Arrange (done with let)

      #Act
      user = vote.user #a vote belonging to a user

      #Assert
      expect(vote).must_be_instance_of User
      expect(user.id).must_equal vote.user_id
    end
  end
