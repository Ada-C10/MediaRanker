require "test_helper"

describe Work do
  let(:work) { works(:hp) }

  it "must be valid" do
    value(work).must_be :valid?
  end

  describe 'relationships' do
    it 'has many votes' do
      # Arrange is done with let

      # Act & Assert
      expect(work).must_be_instance_of Work
      expect(work.votes).must_be_instance_of Array
      expect(work.votes.first).must_be_instance_of Vote
    end
  end

  describe 'validations' do
    it 'must have a title' do
      # Arrange
      work.title = nil

      # Act
      valid = work.valid? # run validations

      # Assert
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    # custom validation? only matters within the category
    # it 'requires a unique title' do
    #   other_work = Work.new title: work.title, category: 'book'
    #
    #   work.save
    #   valid = other_work.valid?
    #
    #   expect(valid).must_equal false
    #   expect(other_work.errors.messages).must_include :title
    # end
  end
end
