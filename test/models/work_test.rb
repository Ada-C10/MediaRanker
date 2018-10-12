require "test_helper"
require 'pry'

describe Work do
  let(:vote) { votes(:vote_one) }
  let(:user) { users(:jackie) }
  let(:hp) { works(:hp) }
  let(:startrek) { works(:startrek) }
  let(:interstellar) { works(:interstellar) }
  let(:sgtpepper) { works(:sgtpepper) }

  it "must be valid" do
    value(hp).must_be :valid?
  end

  it 'has required fields' do
    fields = [:category, :title, :creator, :publication_year,
      :description, :votes]

    fields.each do |field|
      expect(hp).must_respond_to field
    end
  end

  describe 'relationships' do
    it 'has many votes' do
      # Arrange is done with let

      # Act
      votes = hp.votes

      # Assert
      expect(hp).must_be_instance_of Work

      expect(votes.length).must_be :>=, 1
      votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

    it 'can have 0 votes' do
      # Act
      votes = interstellar.votes

      # Assert
      expect(interstellar).must_be_instance_of Work

      expect(votes.length).must_equal 0
      expect(interstellar.valid?).must_equal true
    end

    it 'has many users through votes' do
      # Act
      votes = hp.votes

      # Assert
      expect(hp).must_be_instance_of Work

      expect(votes.length).must_be :>=, 1
      votes.each do |vote|
        expect(vote.user).must_be_instance_of User
      end
    end
  end

  describe 'validations' do
    it 'must have a category' do
      # Arrange
      hp.category = nil

      # Act
      valid = hp.valid? # run validations

      # Assert
      expect(valid).must_equal false
      expect(hp.errors.messages).must_include :category
      expect(hp.errors.messages[:category]).must_equal ["can't be blank"]

      # Rearrange
      hp.category = "books"

      # Re-Act
      valid = hp.valid? # run validations

      # Reassert
      expect(valid).must_equal true
    end

    it 'must have a title' do
      # Arrange
      hp.title = nil

      # Act
      valid = hp.valid? # run validations

      # Assert
      expect(valid).must_equal false
      expect(hp.errors.messages).must_include :title
      expect(hp.errors.messages[:title]).must_equal ["can't be blank"]

      # Rearrange
      hp.title = "Harry Potter"

      # Re-Act
      valid = hp.valid? # run validations

      # Reassert
      expect(valid).must_equal true
    end

    it 'requires a unique title within a category' do
      other_work = Work.new title: hp.title, category: 'book'

      valid = other_work.valid?

      expect(valid).must_equal false
      expect(other_work.errors.messages).must_include :title
      expect(other_work.errors.messages[:title]).must_equal ["has already been taken"]
    end

    it 'can have the same title as a work in a different category' do
      other_work = Work.new title: hp.title, category: 'movie'

      valid = other_work.valid?

      expect(valid).must_equal true
    end
  end

  describe 'spotlight' do
    it 'should return a work object' do
      # Arrange & Act
      work = Work.spotlight

      # Assert
      expect(work).must_be_instance_of Work
    end

    it 'should return a work with the most votes of all work objects' do
      # Act
      top_work = Work.spotlight
      vote_count = top_work.votes.length

      # Assert
      expect(top_work).must_be_instance_of Work
      expect(vote_count).must_equal Work.all.max_by { |work| work.votes.length }.votes.length
    end

    it 'should return the first work alphabetically if there is a vote tie' do
      # Arrange
      # sgtpepper and startrek tied for votes in fixtures

      # Act
      top_work = Work.spotlight

      # Assert
      expect(top_work).must_equal sgtpepper
    end


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

  describe 'list_of' do
    it 'should return an array of only album, movie, or book works' do
      # Act
      works = Work.list_of("album")

      # Assert
      expect(works).must_be_instance_of Array

      works.each do |work|
        expect(work).must_be_instance_of Work
        expect(work.category).must_equal "album"
      end

      # Re-Act
      works = Work.list_of("book")

      # Reassert
      expect(works).must_be_instance_of Array

      works.each do |work|
        expect(work).must_be_instance_of Work
        expect(work.category).must_equal "book"
      end

      # Re-act
      works = Work.list_of("movie")

      # Reassert
      expect(works).must_be_instance_of Array

      works.each do |work|
        expect(work).must_be_instance_of Work
        expect(work.category).must_equal "movie"
      end
    end

    it 'should return the works ordered by vote count and then alphabetically' do
      # Arrange
      hp.update(category: "movie")
      sgtpepper.update(category: "movie")

      # Act
      works = Work.list_of("movie")

      # Assert
      expect(works[0].vote_count >= works[1].vote_count).must_equal true
      expect(works[1].vote_count >= works[2].vote_count).must_equal true
      expect(works.first).must_equal sgtpepper
      expect(works[1]).must_equal startrek
      expect(works[2]).must_equal hp
    end

    it 'should return an empty array when there are none of the designated type of work' do
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
      works = Work.list_of("album")

      # Assert
      expect(works).must_be_instance_of Array
      expect(works.length).must_equal 0
    end
  end

  describe 'vote_count' do
    it 'must return the total number of votes on a work' do
      # Arrange in fixture
      # Act
      count = hp.vote_count

      # Assert
      expect(count).must_equal 1
    end

    it 'returns 0 when the work has no votes on anything' do
      # Arrange
      interstellar = works(:interstellar)

      # Act
      count = interstellar.vote_count

      # Assert
      expect(count).must_equal 0
    end
  end
end
