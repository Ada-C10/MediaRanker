require "test_helper"

describe Work do
  describe 'validations' do
    before do
      # Arrange
      @work = Work.new(title: 'test')
    end

    it 'is invalid without a title' do
    # Arrange
    @work.title = nil

    # Act
    result = @work.valid?

    # Assert
    expect(result).must_equal false
    expect(@work.errors.messages).must_include :title
    end
  end
  describe "sort_works" do
    it "sorts works based on votes" do
      sorted = Work.sort_works("album")
      first = sorted.first.votes.count
      last = sorted.last.votes.count
       expect(first).must_be :>=, last
    end
     it "correctly displays no works" do
      sorted = Work.sort_works("album")
       expect(sorted.length).must_equal 0
     end
  end
   describe "list top ten method" do
     it "sorts works in descending order by votes" do
      sorted = Work.list_top_ten("album")
      first = sorted.first.votes.count
      last = sorted.last.votes.count
       expect(first).must_be :>=, last
    end
    it "displays 10 works" do
      sorted = Work.list_top_ten("book")
       expect(sorted.length).must_be :<=, 10
    end
  end
   describe "top works" do
    it "selects work with highest votes as top work" do
      sorted = Work.find_top_work
      max = Work.all.max_by { |work| work.votes.count }
       expect(sorted.votes.count).must_equal max.votes.count
    end
  end
end
