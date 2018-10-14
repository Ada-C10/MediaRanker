require "test_helper"

describe Work do
  let(:ten) {works(:ten)}
  let(:fire) {works(:fire)}
  let (:vale) {works(:vale)}


  it "must be valid if all params are filled correctly" do
    expect(ten.valid?).must_equal true
  end

  it "must have a title" do
    ten.title = nil
    expect(ten.valid?).must_equal false
    expect(ten.errors.messages).must_include :title
  end

  it "must have a publication_year" do
    fire.publication_year = nil
    expect(fire.valid?).must_equal false
    expect(fire.errors.messages).must_include :publication_year
  end

  it "must have a publication_year that is year between now and the year 1000" do
    fire.publication_year = "year"
    expect(fire.valid?).must_equal false

    fire.publication_year = 5
    expect(fire.valid?).must_equal false

    fire.publication_year = 1984
    expect(fire.valid?).must_equal true

    fire.publication_year = 7777
    expect(fire.valid?).must_equal false
  end

  describe "uniqueness of works in a given category" do
  it "must not allow the same name in a category" do
    duplicate = Work.new(title: vale.title, category: vale.category, creator: "someone", publication_year: 1988, description: "whatever")
    expect(duplicate.valid?).must_equal false
  end
  it "must allow the same name in a different category" do
    duplicate = Work.new(title: vale.title, category: ten.category, creator: "someone", publication_year: 1988, description: "whatever")
    expect(duplicate.valid?).must_equal true
  end
  end

  describe "sorting methods" do
    it "puts the media in the correct category" do
      expect(Work.movies).must_include fire
      expect(Work.albums).must_include ten
      expect(Work.books).must_include vale

    end
  end
end
