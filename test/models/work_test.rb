require "test_helper"

describe Work do

  describe 'validations' do

    it 'creates a new instance of work' do
      work = Work.new
      expect(work).must_be_instance_of Work
    end

    it 'is valid with all field in work complete' do
      work = works(:book)
      expect(work.valid?).must_equal true
    end

    it 'is invalid if title is blank' do
      work = works(:album)
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :title
    end

    it 'is invalid if title is not unique' do
      work = works(:book)
      work = Work.new(title: "Harry Potter and the Goblet of Fire" )

      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :title
    end

    it 'is invalid if title is not longer than 5 char' do
      work = works(:movie)
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :title
    end

    it 'is invalid if creator is not present' do
      work = works(:creator)
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :creator
    end

    it 'is invalid if publication year is not a number' do
      work = works(:publication)
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :publication_year
    end

    it 'is invalid if description is blank' do
      work = works(:publication)
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :description
    end

    it 'is invalid if publication_year is less than 999 and greater than 10000' do
      less = Work.new(publication_year: 998)
      more = Work.new(publication_year: 10001)

      expect(less.valid?).must_equal false
      expect(more.valid?).must_equal false
      expect(less.errors.messages).must_include :publication_year
    end

    describe 'relationships' do
      before(:each) do
        user = users(:jazz)
        work = works(:book2)
        user.works << work
      end

      it "should have created a relationship" do
        Vote.first.user.must_be_instance_of User
        Vote.first.work.must_be_instance_of Work
      end

    end

    describe 'custom methods' do
      let (:book) {works(:book)}
      let (:book2) {works(:book2)}
      let (:book3) {works(:book3)}
      let (:album1) {works(:album1)}
      let (:blank) {works(:blank)}

      it "sorts work by vote count" do
        expect(Work.list_by_votes("book").first.title).must_equal book2.title
        expect(Work.list_by_votes("book").last.title).must_equal book.title
        expect(Work.list_by_votes("album").first.title).must_equal album1.title
      end

      it "expects category to be empty if no work is listed" do
        expect(Work.list_by_votes("dvd")).must_be :empty?
      end
    end


    end
  end
