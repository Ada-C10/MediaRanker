require "test_helper"

describe Work do
  let(:work) { works(:one) }

  it "must be valid" do
    expect(work).must_be :valid?
  end


  describe "validations" do
    it "won't be valid without title" do
      work = works(:one)
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
      new_work = Work.new(title: "workworkworkworkwork", category: "movie", creator: "memyselfandI", publication_year: 1, description: "test-description")

      new_result = new_work.valid?

      expect(new_result).must_equal true
    end

    it "will only be valid with correct category" do
      work = works(:one)

      result = work.valid?
      expect(result).must_equal true
    end

    it "will not be valid without correct category" do
      work = works(:one)
      work.category = "film-reel"

      result = work.valid?
      expect(result).wont_equal true
    end

    it "will not be valid without a publication year" do
      work = works(:one)
      work.publication_year = nil

      result = work.valid?

      expect(result).wont_equal true
    end

    it "will not be valid without creator present" do
      work = works(:one)
      work.creator = nil

      result = work.valid?

      expect(result).wont_equal true
    end

    it "will not be valid without description present" do
      work = works(:one)
      work.description = nil

      result = work.valid?

      expect(result).wont_equal true
    end
  end

end
