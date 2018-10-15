require "test_helper"
require 'pry'

describe Work do
  let(:work) { Work.new(title: 'test') }

  it "must be valid" do
    value(work).must_be :valid?
  end

  describe 'validations' do
    before do
      @work = Work.new(
        title: 'test title')
    end

    it 'is valid when title is present and unique' do

      is_valid = @work.valid?
      expect( is_valid ).must_equal true
    end

    it 'is invalid with a non-unique title' do
      @work.title = Work.first.title

      is_valid = @work.valid?

      expect( is_valid ).must_equal false
      expect( @work.errors.messages ).must_include :title
    end

    it 'is invalid with a missing title' do
      @work.title = nil

      is_valid = @work.valid?

      expect( is_valid ).must_equal false

      expect ( @work.errors.messages ).must_include :title
    end
  end

  describe 'list_works_by_category' do

    it 'correctly filters the list for a category' do
      book_list = Work.list_works_by_category('book')
      expect ( book_list.first.category ).must_equal 'book'
    end

    it 'correctly collects all the works in a category' do
      book_list = Work.list_works_by_category('book')
      expect ( book_list.length ).must_equal 2
    end
  end

  describe 'orders works in a category by votes' do

    it 'correctly lists works in order of votes, most' do
      expect ( Work.order_works_by_category('book').first.id ).must_equal 298486374
    end

    it 'correctly lists works in order of votes, least' do
      expect ( Work.order_works_by_category('book').last.id ).must_equal 980190962
    end
  end
end
