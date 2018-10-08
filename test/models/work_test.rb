require "test_helper"

describe Work do
  let(:work) { works(:book) }

  it "must be valid" do
    value(work).must_be :valid?
  end

  it 'presence of required fields' do
    fields = [:title, :category, :creator, :publication_year, :description]

    fields.each do |field|
      expect(work).must_respond_to field
    end
  end

  describe 'validations' do
    it 'must have a title' do
      # Arrange
      work = works(:book)
      work.title = nil

      # Act
      #valid = book.valid?
      valid = work.save

      # Assert
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :title
    end

    it 'requires a unique title' do
      other_work = works(:album)
      #change the title to the work title we set above (work points to book in the test data)
      other_work.title = work.title

      valid = other_work.valid?

      expect(valid).must_equal false
      expect(other_work.errors.messages).must_include :title
    end

    it 'must have an creator' do
      # Arrange
      work = works(:book)
      work.creator = nil

      # Act
      #valid = book.valid?
      valid = work.save

      # Assert
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :creator
    end

    it 'requires a unique creator' do
      other_work = works(:album)
      #change the title to the work title we set above (work points to book in the test data)
      other_work.creator = work.creator

      valid = other_work.valid?

      expect(valid).must_equal false
      expect(other_work.errors.messages).must_include :creator
    end
  end


















end
