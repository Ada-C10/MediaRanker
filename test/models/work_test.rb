require "test_helper"

describe Work do
  let(:work) { works(:work1) }

  it "must be valid" do
    expect(work).must_be :valid?
  end


  describe "validations" do
    describe "relationships" do
      it "has a relationship with votes" do
        work = works(:work1)

        result = work.votes

        expect(result.first).must_be_kind_of Vote
        expect(result.count).must_equal 2
      end

      it "has a relationship with users through votes" do
        work = works(:work2)

        result = work.users

        expect(result.first).must_be_kind_of User
        expect(result.count).must_equal 2
      end
    end

    it "won't be valid without title" do
      work = works(:work1)
      work.title = nil

      result = work.valid?

      expect(result).wont_equal true
    end

    it "will be valid with a title" do
      result = work.valid?
      expect(result).must_equal true
    end

    it "won't be valid without unique title" do
      new_work = Work.new(title: Work.first.title)

      result = new_work.valid?

      expect(result).wont_equal true
    end

    it "will be valid with unique title" do
      new_work = Work.new(title: "workworkworkworkwork", category: "movie", creator: "memyselfandI", publication_year: 1999, description: "test-description")

      new_result = new_work.valid?

      expect(new_result).must_equal true
    end

    it "will only be valid with correct category" do
      work = works(:work1)

      result = work.valid?
      expect(result).must_equal true
    end

    it "will not be valid without correct category" do
      work = works(:work1)
      work.category = "film-reel"

      result = work.valid?
      expect(result).wont_equal true
    end

    it "will not be valid without a publication year" do
      work = works(:work1)
      work.publication_year = nil

      result = work.valid?

      expect(result).wont_equal true
    end

    it "will not be valid if year is less than 1700 " do
      work = works(:work1)

      work.publication_year = 1699

      result = work.valid?

      expect(result).wont_equal true
    end

    it "will be valid if year is between 1700 and current year" do
      work = works(:work1)

      work.publication_year = 2010

      result = work.valid?

      expect(result).must_equal true
    end

    it "will not be valid if year is greater than current year" do
      work = works(:work1)

      work.publication_year = 2019

      result = work.valid?

      expect(result).wont_equal true
    end

    it "will not be valid without creator present" do
      work = works(:work1)
      work.creator = nil

      result = work.valid?

      expect(result).wont_equal true
    end

    it "will not be valid without description present" do
      work = works(:work1)
      work.description = nil

      result = work.valid?

      expect(result).wont_equal true
    end
  end

  describe "self.show_by_vote(category)" do
    it "returns sorted movies in descending order based on votes" do
      @books = Work.show_by_vote("book")
      book_result = @books.length.times do |i|
        if @books.length <= 1
          return true
        elsif @books[i].votes.count >= @books[i + 1].votes.count
          return true
        else
          return false
        end
      end

      expect(@books).must_be_kind_of Array
      expect(@book_result).must_equal true
    end

    it "returns sorted movies in descending order based on votes" do
      @movies = Work.show_by_vote("movie")

      movie_result = @movies.length.times do |i|
        if @movies.length <= 1
          return true
        elsif @movies[i].votes.count >= @movies[i + 1].votes.count
          return true
        else
          return false
        end
      end

      expect(@movies).must_be_kind_of Array
      expect(@movie_result).must_equal true
    end

    it "returns sorted albums in descending order based on votes" do
      @albums = Work.show_by_vote("album")

      album_result = @albums.length.times do |i|
        if @albums.length <= 1
          return true
        elsif @albums[i].votes.count >= @albums[i + 1].votes.count
          return true
        else
          return false
        end
      end

      expect(@books).must_be_kind_of Array
      expect(@album_result).must_equal true
    end
  end

  it "will will be invalid without valid category" do
    @shows = Work.show_by_vote("shows")
    if @shows.length < 1
      result = nil
    end

    if result == nil
      result = "invalid"
    else
      result = "valid"
    end

    expect(result).must_equal "invalid"
  end


  describe "self.top_vote" do
    it "returns work with the max number of votes" do
      @top_work = Work.top_vote

      works = Work.all

      result = works.each do |work|
        @top_work.votes.count >= work.votes.count
        return true
      else
        return false
      end

      expect(result).must_equal true
    end
  end

end
