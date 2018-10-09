require "test_helper"

describe Work do
  let(:work) { works(:wheel_of_time) }

  it "must be valid" do
    value(work).must_be :valid?
  end

  describe 'Relationships' do
    it 'can have many votes' do
      work.votes << Vote.first
      votes = work.votes

      expect(votes.length).must_be :>=, 0
      votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end 
    end
  end

  describe 'validations' do
    it 'must have a title' do
      work.title = nil

      valid = work.valid?

      expect(valid).must_equal false
      expect(work.errors.messages).must_include :title
    end

    it 'must have a unique title' do
      work2 = works(:harry_potter)
      work2.title = work.title

      valid = work2.valid?

      expect(valid).must_equal false
      expect(work2.errors.messages).must_include :title
    end

    it 'must have a creator' do
      work.creator = nil

      valid = work.valid?

      expect(valid).must_equal false
      expect(work.errors.messages).must_include :creator
    end

    it 'must have a year published' do
      work.publication_year = nil

      valid = work.valid?

      expect(valid).must_equal false
      expect(work.errors.messages).must_include :publication_year
    end

    it 'must have a numerical year published' do
      work.publication_year = 'seaweed'

      valid = work.valid?

      expect(valid).must_equal false
      expect(work.errors.messages).must_include :publication_year
    end

    it 'must have a category' do
      #is this the correct test for a select drop down?
      work.category = nil

      valid = work.valid?

      expect(valid).must_equal false
      expect(work.errors.messages).must_include :category
    end

    it 'must have a description' do
      work.description = nil

      valid = work.valid?

      expect(valid).must_equal false
      expect(work.errors.messages).must_include :description
    end

  end
end
