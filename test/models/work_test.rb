require "test_helper"

describe Work do

  describe 'relations' do

    before do
      @work = works(:blue)
      @work.save
    end

    it "must be valid when all fields are present" do
      @work.title.must_equal "Blue Breaker"
      is_valid = @work.valid?
      expect( is_valid ).must_equal true
    end

    it "must  NOT be valid when all fields are not present" do
      work1 = Work.new(title: "The name of the wind")

      is_valid = work1.valid?
      expect( is_valid ).must_equal false
    end


    it "must not be valid for duplicate title with the same category" do
      work1 = Work.new(title: @work.title, category: @work.category)
      is_valid = work1.valid?
      expect( is_valid ).must_equal false
    end


    it "must be valid for same title but different category" do
      work1 = Work.new(title: @work.title, category: "movie")

      is_valid = work1.valid?
      expect( is_valid ).must_equal true
      expect( work1.title ).must_equal @work.title
    end


    it "nil title is not valid" do
      @work.title = nil
      result = @work.valid?

      expect(result).must_equal false
      expect(@work.errors.messages).must_include :title
    end



    it "returns the work with the most votes" do
      @works = Work.all.to_a
      @works = (@works.sort_by { |work| work.total_votes()}).reverse!

      votes = []
      @works.each do |work|
        votes << work.total_votes
      end

      expect(votes.length).must_equal 4
      expect(votes.first).must_equal 3
      expect(@works.first.title).must_equal "Blue Breaker"
      expect(@works.first.category).must_equal "album"
      expect(@works.first.creator).must_equal "Dr. Sarai Langosh"

    end



    it "returns the top work within a certain category (album)" do


      @albums = Work.where(category: "album")

      @albums = ((@albums.sort_by { |album| album.total_votes()}).reverse!).take(1)


      votes = []
      @albums.each do |album|
        votes << album.total_votes
      end

      expect(@albums.length).must_equal 1
      expect(@albums).must_be_kind_of Array

      expect(@albums.first.title).must_equal "Blue Breaker"
      expect(@albums.first.category).must_equal "album"
      expect(@albums.first.creator).must_equal "Dr. Sarai Langosh"

    end





  end


end
