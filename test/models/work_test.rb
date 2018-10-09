require "test_helper"

describe Work do
  let(:work) { works(:hp) }
  let(:vote) { votes(:vote_one) }

  it "must be valid" do
    value(work).must_be :valid?
  end

  it 'has required fields' do
    fields = [:category, :title, :creator, :publication_year,
      :description, :votes]

    fields.each do |field|
      expect(work).must_respond_to field
    end
  end

  describe 'relationships' do
    it 'has many votes' do
      # Arrange is done with let

      # Act
      votes = work.votes

      # Assert
      expect(work).must_be_instance_of Work

      expect(votes.length).must_be :>=, 1
      votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

    it 'has many users through votes' do
      # Arrange is done with let

      # Act
      votes = work.votes

      # Assert
      expect(work).must_be_instance_of Work

      expect(votes.length).must_be :>=, 1
      votes.each do |vote|
        expect(vote.user).must_be_instance_of User
      end
    end
  end

  describe 'validations' do
    it 'must have a category' do
      # Arrange
      work.category = nil

      # Act
      valid = work.valid? # run validations

      # Assert
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :category
      expect(work.errors.messages[:category]).must_equal ["can't be blank"]

      # Rearrange
      work.category = "books"

      # Re-Act
      valid = work.valid? # run validations

      # Reassert
      expect(valid).must_equal true
    end

    it 'must have a title' do
      # Arrange
      work.title = nil

      # Act
      valid = work.valid? # run validations

      # Assert
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]

      # Rearrange
      work.title = "Harry Potter"

      # Re-Act
      valid = work.valid? # run validations

      # Reassert
      expect(valid).must_equal true
    end

    it 'requires a unique title' do
      other_work = Work.new title: work.title, category: 'book'

      valid = other_work.valid?

      expect(valid).must_equal false
      expect(other_work.errors.messages).must_include :title
      expect(other_work.errors.messages[:title]).must_equal ["has already been taken"]
    end
  end

  describe 'spotlight' do
    it 'should return a work object' do
      # Arrange & Act
      work = Work.spotlight

      # Assert
      expect(work).must_be_instance_of Work
    end

    it 'should have the most votes of all work objects' do
      # Arrange
      10.times do
        Work.first.votes << Vote.new
      end

      # Act
      top_work = Work.spotlight
      vote_count = top_work.votes.length

      # Assert
      expect(vote_count).must_equal Work.all.max_by { |work| work.votes.length }.votes.length
    end

    # TODO: tiebreakers
    # it 'should return the one thats first alphabetically if theres a tie' do
    # end

    # TODO: Need to account for this in the view
    it 'should return nil if there are no works' do
      # Arrange
      Work.all.each do |work|
        work.votes.each do |vote|
          vote.destroy
        end
        work.destroy
      end

      # Act
      top_work = Work.spotlight

      # Assert
      expect(top_work).must_be_nil
    end
  end

  describe 'albums' do
    it 'should return an array of only album works' do
      # Act
      works = Work.albums

      # Assert
      expect(works).must_be_instance_of Array

      works.each do |work|
        expect(work).must_be_instance_of Work
        expect(work.category).must_equal "album"
      end
    end

    it 'should return an empty array when there are no albums' do
      # Arrange
      Work.all.each do |work|
        if work.category == "album"
          work.votes.each do |vote|
            vote.destroy
          end
          work.destroy
        end
      end

      # Act
      works = Work.albums

      # Assert
      expect(works).must_be_instance_of Array
      expect(works.length).must_equal 0
    end
  end

  describe 'books' do
    it 'should return an array of only book works' do
      # Act
      works = Work.books

      # Assert
      expect(works).must_be_instance_of Array

      works.each do |work|
        expect(work).must_be_instance_of Work
        expect(work.category).must_equal "book"
      end
    end

    it 'should return an empty array when there are no books' do
      # Arrange
      Work.all.each do |work|
        if work.category == "book"
          work.votes.each do |vote|
            vote.destroy
          end
          work.destroy
        end
      end

      # Act
      works = Work.books

      # Assert
      expect(works).must_be_instance_of Array
      expect(works.length).must_equal 0
    end
  end

  describe 'movies' do
    it 'should return an array of only movie works' do
      # Act
      works = Work.movies

      # Assert
      expect(works).must_be_instance_of Array

      works.each do |work|
        expect(work).must_be_instance_of Work
        expect(work.category).must_equal "movie"
      end
    end

    it 'should return an empty array when there are no movies' do
      # Arrange
      Work.all.each do |work|
        if work.category == "movie"
          work.votes.each do |vote|
            vote.destroy
          end
          work.destroy
        end
      end

      # Act
      works = Work.movies

      # Assert
      expect(works).must_be_instance_of Array
      expect(works.length).must_equal 0
    end
  end
end
