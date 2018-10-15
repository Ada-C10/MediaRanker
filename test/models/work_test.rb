require "test_helper"

describe Work do
  let(:work) { works(:treat) }

  describe 'Validations' do

    it 'is valid when all fields are present' do
      result = work.valid?
      expect(result).must_equal true
    end

    it 'it has required fields' do
      fields = [:title, :creator, :category, :publication_year, :description]

      fields.each do |field|
        expect(work).must_respond_to field
      end
    end

    it 'is not valid when the title of the media is not unique' do
      work_copy = work.dup

      assert_not work_copy.valid?
    end

  end

  describe 'Relationships' do
    describe "#upvote" do
      let(:work) { works(:breaker) }
      let(:user) { users(:one) }

      it "should create a new vote" do
        expect(work.votes.count).must_equal 0

        work.upvote(user)

        expect(work.votes.count).must_equal 1
      end

      it "should associate a user with the work" do
        expect(work.users.count).must_equal 0
        work.upvote(user)
        expect(work.users.count).must_equal 1
      end
    end
  end

  describe 'highest_rated' do
    it "should return works in order of votes" do
      work_1 = works(:ben)
      work_2 = works(:breaker)
      work_3 = works(:treat)

      user_1 = users(:one)
      user_2 = users(:two)

      work_1.upvote(user_1)
      work_1.upvote(user_2)

      work_2.upvote(user_1)

      expect(Work.highest_rated).must_equal([work_1, work_2, work_3])
    end
  end

end
