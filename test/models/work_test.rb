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

    it "is not valid if title or category is nil" do
      work = Work.new(title: "jumanji", creator: "Joe Johnston")
      result = work.valid?

      expect(result).must_equal false
    end

  end


end
