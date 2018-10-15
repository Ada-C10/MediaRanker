require "test_helper"

describe Work do
  describe "validations" do
    let(:titanic) { works(:titanic) }
    let(:the_big_lebowski) { works(:the_big_lebowski) }

    it "must be valid" do
      value(titanic).must_be :valid?
    end

    it 'is invalid without a title' do
      # Arrange
      titanic.title = nil
      # Act
      result = titanic.valid?
      # Assert
      expect(result).must_equal false
    end

    it 'a title can only occur once per category ' do
      # Arrange
      the_big_lebowski.title = titanic.title
      # Act
      result = the_big_lebowski.save
      # Assert
      expect(result).must_equal false
    end

    it 'is invalid without a creator' do
      # Arrange
      titanic.creator = nil
      # Act
      result = titanic.valid?
      # Assert
      expect(result).must_equal false
    end

    it 'is invalid without a publication year' do
      # Arrange
      titanic.publication_year = nil
      # Act
      result = titanic.valid?
      # Assert
      expect(result).must_equal false
    end

    it 'a publication year must be an integer' do
      # Arrange
      titanic.publication_year = "hello"
      # Act
      result = titanic.valid?
      # Assert
      expect(result).must_equal false
    end

    it 'a publication year must be greater than 0' do
      # Arrange
      titanic.publication_year = -1
      # Act
      result = titanic.valid?
      # Assert
      expect(result).must_equal false
    end

    it 'a publication year must be greater less than 2019' do
      # Arrange
      titanic.publication_year = 3000
      # Act
      result = titanic.valid?
      # Assert
      expect(result).must_equal false
    end

    it 'is invalid without a description' do
      # Arrange
      titanic.description = nil
      # Act
      result = titanic.valid?
      # Assert
      expect(result).must_equal false
    end

    it 'a category must be a book, movie, or album' do
      # Arrange
      titanic.category = "cat"
      # Act
      result = titanic.valid?
      # Assert
      expect(result).must_equal false
    end

    it 'a description must be 5 or more characters' do
      # Arrange
      titanic.description = "cat"
      # Act
      result = titanic.valid?
      # Assert
      expect(result).must_equal false
    end

    it 'a description may not be more than 250 characters' do
      # Arrange
      titanic.description = "testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest"
      # Act
      result = titanic.valid?
      # Assert
      expect(result).must_equal false
    end
  end

  describe "custom methods" do
    it 'display a list of albums' do
      Work.category_list('album').each do |work|
        expect(work.category).must_equal "album"
      end
    end

    it 'display a list of Movies' do
      Work.category_list('movie').each do |work|
        expect(work.category).must_equal "movie"
      end
    end

    it 'display a list of Books' do
      Work.category_list('book').each do |work|
        expect(work.category).must_equal "book"
      end
    end

    it 'display a list of top movies' do
      expect(Work.top_category_list('movie')[0].title).must_equal "Titanic"
    end

    it 'display a list of top books' do
      expect(Work.top_category_list('book')[0].title).must_equal "Harry Potter"
    end

    it 'display a list of top albums' do
      expect(Work.top_category_list('album')[0].title).must_equal "Spice World"
    end
  end

  describe "relationships" do
    let(:titanic) { works(:titanic) }

    it 'can have many votes' do
      votes = titanic.votes
      expect(votes.length).must_be :>=, 1
      votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end
end
