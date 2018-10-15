require "test_helper"

describe Work do
  describe 'validations' do

    it "is valid with all field information provided" do
      work = works(:clueless)
      result = work.valid?

      expect(result).must_equal true
    end

    it "is valid with only title and category provided" do
      work = works(:memento)
      result = work.valid?

      expect(result).must_equal true
    end

    it "is invalid if category is nil" do
      work = Work.new(title: "jumanji", creator: "Joe Johnston")
      result = work.valid?

      expect(result).must_equal false
      expect(work.errors.messages).must_include :category
    end

    it "is invalid if title is nil" do
      work = Work.new(title: nil, category: "book")
      result = work.valid?

      expect(result).must_equal false
      expect(work.errors.messages).must_include :title
    end

    it "is invalid when title is not unique" do
      work = Work.new(title: works(:memento).title, category: "movie")
      result = work.valid?

      expect(result).must_equal false
      expect(work.errors.messages).must_include :title
    end

    it "is invalid when category is not one of given categories" do
      work = Work.new(title: "Rugrats", category: "biopic")
      result = work.valid?

      expect(result).must_equal false
      expect(work.errors.messages).must_include :category
    end
  end


  describe 'relations' do
    it "has votes" do
      votes = works(:rhymes).votes

      votes.count.must_equal 3
    end
  end

  describe 'votes_count' do
    it "counts the number of votes a work has" do
      work = works(:rhymes)
      work.votes_count.must_equal 3
    end

    it "returns 0 if there are no votes for a work" do
      work = works(:kveikur)
      work.votes_count.must_equal 0
    end
  end

  describe 'get_category_media' do
    before do
      @works = Work.get_category_media("movie")
    end
    it "gets all works of a given category" do
      @works.first.category.must_equal "movie"
      @works.count.must_equal 3
    end

    it "sorts list in order of votes" do
      @works.first.title.must_equal works(:memento).title
    end
  end

  describe "get_top_list" do
    it "returns a list of no more than ten works" do
      @works = Work.all
      @works.count.must_be :<, 11
    end

    # add more fixtures so can test with over ten category works? 
  end
end
