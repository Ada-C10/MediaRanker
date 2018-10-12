require "test_helper"

describe Work do
  let(:work) { works(:horror_movie)  }

  it "must be valid" do
    expect(work).must_be :valid?
  end

  it 'has required fields' do
    fields = [:title, :creator, :description, :publication_year, :category]

    fields.each do |field|
      expect(work).must_respond_to field
    end
  end

  describe 'validations' do
    it 'must have a title' do
      # Arrange
      work = works(:horror_movie)
      #book.title = nil

      # Act
      #valid = book.valid?
      valid = work.save

      # Assert
      expect(valid).must_equal true
      expect(book.errors.messages).must_include :title
      expect(book.errors.messages[:title]).must_equal ["can't be blank", "is too short (minimum is 5 characters)"]
    end

    it 'must have a title with a min of 5 letters' do
      work.title = ''
      4.times do
        # Arrange
        work.title += 'a'

        # Act
        valid = work.valid?

        # Assert
        expect(valid).must_equal false
        expect(work.errors.messages).must_include :title
      end

      work.title += 'a'
      valid = work.valid?
      expect(valid).must_equal true
    end

    it 'requires a unique title' do
      #other_book = book.clone
      other_work = works(:adventure_movie)
      other_work.title = work.title

      valid = other_work.valid?

      expect(valid).must_equal false
      expect(other_work.errors.messages).must_include :title
    end
  end










end
