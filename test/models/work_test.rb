require "test_helper"

describe Work do
  let(:work) { works(:hp) }
  let(:vote) { votes(:vote_one) }
  let(:user) { users(:jackie) }

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
        Work.first.votes << Vote.new(user: user, work: work)
      end

      # Act
      top_work = Work.spotlight
      vote_count = top_work.votes.length

      # Assert
      expect(vote_count).must_equal Work.all.max_by { |work| work.votes.length }.votes.length
    end

    it 'should return the first work alphabetically if there is a vote tie' do
      # Arrange
      15.times do
        works(:sgtpepper).votes << Vote.new(user: user, work: work)
      end

      # Act
      top_work = Work.spotlight

      # Assert
      expect(top_work).must_equal works(:sgtpepper)

      # Re-Arrange
      # 16 times because sgtpepper has existing extra vote from fixture
      16.times do
        works(:interstellar).votes << Vote.new(user: user, work: work)
      end
      # Act
      top_work = Work.spotlight

      # Assert
      expect(top_work).must_equal works(:interstellar)
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
      works(:sgtpepper).category = "book"
      works(:sgtpepper).save
      works(:interstellar).category = "book"
      works(:interstellar).save

      # Act
      works = Work.list_of("book")

      # Assert
      expect(works[0].vote_count >= works[1].vote_count).must_equal true
      expect(works[1].vote_count >= works[2].vote_count).must_equal true

      # Re-Arrange
      15.times do
        works(:sgtpepper).votes << Vote.new(user: user, work: work)
      end

      # 16 times because sgtpepper has existing extra vote from fixture
      16.times do
        works(:interstellar).votes << Vote.new(user: user, work: work)
      end
      # Act
      works = Work.list_of("book")

      # Assert
      expect(works.first).must_equal works(:interstellar)
      expect(works[0].vote_count >= works[1].vote_count).must_equal true
      expect(works[1].vote_count >= works[2].vote_count).must_equal true
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
      count = work.vote_count

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
