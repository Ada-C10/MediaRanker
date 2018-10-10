require "test_helper"

describe Work do
  let(:work) { works(:hello) }

  it "must be valid" do
    value(work).must_be :valid?
  end

  it 'has required fields' do
    fields = [:category, :title, :creator, :publication_year, :description]

    fields.each do |field|
      expect(work).must_respond_to field
    end
  end

  describe 'Relationships' do
    it 'can have many votes' do

      work.votes << Vote.first
      votes = work.votes

      expect(votes.length).must_be :>=, 1
      votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe 'validations' do
    it 'must have a title' do

      work.title = nil

      valid = work.save

      expect(valid).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]
    end


    it 'requires a unique title' do


      other_work = Work.new
      other_work.title = work.title
      other_work.category = 'Book'

      valid = other_work.valid?

      expect(valid).must_equal false
      expect(other_work.errors.messages).must_include :title
    end

    it 'must have a category' do

      work.category = nil

      valid = work.valid?

      expect(valid).must_equal false
      expect(work.errors.messages).must_include :category
      expect(work.errors.messages[:category]).must_equal ["can't be blank"]
    end
  end
end
