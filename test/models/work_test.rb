require "test_helper"

describe Work do
  let(:work) { works(:harrypotter)  }

  it "must be valid" do
    expect(work).must_be :valid?
  end

  it 'has required fields' do
    fields = [:title, :creator, :description, :publication_year, :category]

    fields.each do |field|
      expect(work).must_respond_to field
    end
  end

  # describe 'Relationships' do
  #   it 'belongs to an author' do
  #     # Arrange (done with let)
  #
  #     # Act
  #     author = book.author
  #
  #     # Assert
  #     expect(author).must_be_instance_of Author
  #     expect(author.id).must_equal book.author_id
  #   end
  #
  #   it 'can have many genres' do
  #     # Arrange, did with let
  #
  #     # Act
  #     book.genres << Genre.first
  #     genres = book.genres
  #
  #
  #     # Assert
  #     expect(genres.length).must_be :>=, 1
  #     genres.each do |genre|
  #       expect(genre).must_be_instance_of Genre
  #     end
  #   end
  # end

  describe 'validations' do
    it 'must have a title' do
      # Arrange
      work = works(:harrypotter)
      work.title = nil

      # Act
      #valid = book.valid?
      valid = work.save

      # Assert
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it 'must have category movie, album or book' do
      # Arrange
      work = works(:harrypotter)
      work.category = 'art'

      # Act
      #valid = book.valid?
      valid = work.save

      # Assert
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :category
    end


    it 'requires a unique title in category' do
      #other_book = book.clone
      other_work = works(:pride)
      other_work.title = work.title
      other_work.category = work.category

      valid = other_work.valid?

      expect(valid).must_equal false
      expect(other_work.errors.messages).must_include :title
    end
    it 'will allow a title that already exits if its in a different category' do
      #other_book = book.clone
      other_work = works(:pride)
      other_work.title = work.title

      valid = other_work.valid?

      expect(valid).must_equal true
    end
  end
end
