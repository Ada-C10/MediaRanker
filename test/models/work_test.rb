require "test_helper"

describe Work do

  describe 'validations' do

    before do
      @work = Work.new(title: 'valid work')
    end

    it 'is valid when title is present and unique' do

      is_valid = @work.valid?

      expect( is_valid ).must_equal true
    end


    it 'is invalid without a title' do

      @work.title = nil

      is_valid = @work.valid?

      expect( is_valid ).must_equal false
      expect( @work.errors.messages ).must_include :title
    end


    it 'is invalid with a non-unique title' do
      @work.title = Work.first.title

      is_valid = @work.valid?

      expect( is_valid ).must_equal false
      expect( @work.errors.messages ).must_include :title
    end

  end


  describe 'relations' do

    it "Has some votes" do
      work = Work.first

      votes = work.votes

      expect(votes).must_respond_to :each
    end

  end


  describe 'total_votes' do

    it 'has one record for each work' do

      all_works = Work.all
      total_works = all_works.length
      works_table = Work.total_votes

      expect(works_table.length).must_equal total_works


      all_works.each do |work|
        expect(works_table).must_include work
      end
    end

    it 'ranks media from most to least votes' do

      works_table = Work.total_votes

      expect(works_table.first.votes.count >= works_table.last.votes.count).must_equal true

    end
  end


  describe 'ranked_media' do

    it 'only contains entries for the category passed in as a parameter' do

      books = Work.ranked_media("Books")

      books.each do |book|
        expect(book).must_be_kind_of Book
      end

    end


    it 'has a vote count for every piece of media' do

      books = Work.ranked_media("Books")

      books.each do |book|
        expect(book).must_respond_to book.votes
      end
    end

  end


  describe 'top_ten' do

    it 'returns only 10 entries of each category' do

      x = 2

      50.times do
        book = Work.new(title: "Title#{x}", category: "Book")
        book.save
        x += 1
      end

      all_books = Work.where(category: "Book")
      ten_books = Work.top_ten("Book")


      expect(all_books.length > ten_books.length).must_equal true

      expect(ten_books.length).must_equal 10

    end

    it 'returns the entry with the highest votes first' do

      ten_books = Work.top_ten("Book")

      expect(ten_books.first.votes.count >= ten_books.last.votes.count).must_equal true
    end
  end

  describe 'top_media' do

    it 'has the most votes out of all media' do

      top = Work.top_media

      all_works = Work.all

      all_works.each do |work|
        expect(work.votes.count <= top.votes.count).must_equal true
      end
    end

    it 'returns a single piece of media' do

      top_media = Work.top_media

      expect(top_media).must_be_kind_of Work

    end

  end
end
