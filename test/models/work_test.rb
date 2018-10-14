require "test_helper"

describe Work do
  let(:work) { works(:wheel_of_time) }

  it "must be valid" do
    value(work).must_be :valid?
  end

  describe 'Relationships' do
    it 'can have many votes' do
      work.votes << Vote.first
      votes = work.votes

      expect(votes.length).must_be :>=, 0
      votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

    it 'can have many users through votes' do
      work.users << User.first
      users = work.users

      expect(work.users.length).must_be :>=, 0
      work.users.each do |user|
        expect(user).must_be_instance_of User
      end
    end
  end

  describe 'validations' do
    it 'must have a title' do
      work.title = nil

      valid = work.valid?

      expect(valid).must_equal false
      expect(work.errors.messages).must_include :title
    end

    it 'must have a unique title' do
      work2 = works(:harry_potter)
      work2.title = work.title

      valid = work2.valid?

      expect(valid).must_equal false
      expect(work2.errors.messages).must_include :title
    end

    it 'must have a creator' do
      work.creator = nil

      valid = work.valid?

      expect(valid).must_equal false
      expect(work.errors.messages).must_include :creator
    end

    it 'must have a year published' do
      work.publication_year = nil

      valid = work.valid?

      expect(valid).must_equal false
      expect(work.errors.messages).must_include :publication_year
    end

    it 'must have a numerical year published' do
      work.publication_year = 'seaweed'

      valid = work.valid?

      expect(valid).must_equal false
      expect(work.errors.messages).must_include :publication_year
    end

    it "must have a year with four digits" do
      work.publication_year = 87

      expect(valid).must_equal false
      expect(work.errors.messages).must_include :publication_year
    end

    it 'must have a category' do
      #is this the correct test for a select drop down?
      work.category = nil

      valid = work.valid?

      expect(valid).must_equal false
      expect(work.errors.messages).must_include :category
    end

    it 'must have a description' do
      work.description = nil

      valid = work.valid?

      expect(valid).must_equal false
      expect(work.errors.messages).must_include :description
    end
  end

  describe "top ten" do

    it "sorts the works in descending order by votes" do
      sorted = Work.top_ten("book")
      first = sorted.first.votes.count
      last = sorted.last.votes.count

      expect(first).must_be :>=, last
    end
    it "displays only ten pieces of work" do
      sorted = Work.top_ten("book")

      expect(sorted.length).must_be :<=, 10
    end
    it "will post nothing if there are no works in a category" do
      sorted = Work.top_ten("album")

      expect(sorted.length).must_equal 0

    end
    it "will post only book if there is only one work in category" do
      sorted = Work.top_ten("movie")

      expect(sorted.length).must_equal 1
    end
  end

  describe "top media" do
    it "must select work with highest work as top work" do
      sorted = Work.top_work
      max = Work.all.max_by { |work| work.votes.count }

      expect(sorted.votes.count).must_equal max.votes.count
    end
  end
end
