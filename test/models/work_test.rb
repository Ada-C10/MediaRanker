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

    it 'must have a publication_year' do
      # Arrange
      # why do I have to define a new variable here, and not just use work
      # work = works(:book)
      work.publication_year = nil

      # Act
      #valid = book.valid?
      valid = work.save

      # Assert
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :publication_year
    end

    it 'must have a valid year' do
      work.publication_year = ''
      3.times do
        # Arrange
        work.publication_year += '1'

        # Act
        valid = work.valid?

        # Assert
        expect(valid).must_equal false
        expect(work.errors.messages).must_include :publication_year
      end

      work.publication_year += '1'
      valid = work.valid?
      expect(valid).must_equal true
    end

    it 'must have a category' do
      work.category = nil

      # Act
      valid = work.valid?

      # Assert
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :category
    end

    it 'has one of the allowed categories' do
      work.category = "music"
      expect(work).wont_be :valid?

      Work::CATEGORIES.each do | category |
        work.category = category
        expect(work).must_equal :valid?
      end
    end




  end



end
