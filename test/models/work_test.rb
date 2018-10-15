require "test_helper"
require 'pry'
describe Work do
  describe 'validations' do
    before do
      # Arrange
      @work = Work.new(category: 'book', title: 'nice title')
    end

    it 'is valid when all fields are present' do
      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal true
    end

    it 'is invalid without a category' do
      # Arrange
      @work.category = nil

      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :category
    end

    it "is invalid without a title" do
      @work.title = nil
      result = @work.valid?

      expect(result).must_equal false
      expect(@work.errors.messages).must_include :title
    end

    it "is invalid if same title already exists" do
      @work.save
      @new_work = Work.new(category: 'book', title: @work.title)
      result = @new_work.valid?

      expect(result).must_equal false
    end
  end

  describe 'relations' do
    it 'can set the work id through new vote' do
      # Create two models
      @work = Work.create!(category: 'book', title: "test books")
      @vote = Vote.new

      # Make the models relate to one another
      @vote.work_id = @work.id

      # author_id should have changed accordingly
      expect(@vote.work_id).must_equal @work.id
    end

    it "has a vote" do
      work = works(:jane)
      work.votes.must_include votes(:one)
    end

    it "can set the work id in vote through work" do
      work = works(:harry)
      vote = votes(:two)
      work.votes << vote

      work.votes.first.id.must_equal votes(:two).id
    end
  end
end
