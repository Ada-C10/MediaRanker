require "test_helper"

describe Work do
  let(:work) { works(:rambo) }
  before do
    @user = User.first
  end

  describe 'validations' do

    it 'is valid when all fields are present' do
      result = work.valid?
      expect(result).must_equal true
    end

    it 'is invalid when title is missing' do
      work.title = nil
      result = work.valid?
      expect(result).must_equal false
      expect(work.errors.messages).must_include :title
    end

    it 'requires a unique name' do
      other_work = works(:reputation)
      other_work.title = work.title
      valid = other_work.valid?
      expect(valid).must_equal false
      expect(other_work.errors.messages).must_include :title

    end

    it 'will only be valid with a correct category' do
      work.category = "ebook"
      valid = work.valid?
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :category
    end

  end

  describe 'relations' do
    it 'can have many votes' do
      # Adding a vote
      work.votes <<
        Vote.new(
            date_created: Date.today,
            user_id: @user.id
        )

      votes = work.votes

      expect(votes.length).must_be :>=, 1
      votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe 'custom methods' do

  end
end
