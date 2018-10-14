require "test_helper"
require 'pry'
describe Work do
  before do
    @work = works(:harry_potter)
    @works = Work.all
  end

  describe 'validations' do

    it 'is valid when all required field are present' do
      expect(@work.valid?).must_equal true
      expect(@work.errors.messages).must_be_empty
    end

    it 'is invalid without category' do
      @work.category = nil
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :category
    end

    it 'is invalid without title' do
      @work.title = nil
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :title
    end

    it 'is invalid without creator' do
      @work.creator = nil
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :creator
    end

    it 'is invalid without integer publication year' do
      @work.publication_year = "ninety"
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :publication_year
    end
  end

  describe 'relations' do
    it 'responds to votes method' do
      expect(@work.votes).must_respond_to :each
      expect(@work.votes.length).must_equal 4
    end
    it 'responds to upvoted_users method' do
      expect(@work.upvoted_users).must_respond_to :each
      expect(@work.upvoted_users.length).must_equal 4
    end
    it 'responds to votes_count method' do
      expect(@work).must_respond_to :votes_count
    end
  end

end
