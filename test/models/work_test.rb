require "test_helper"

describe Work do
  let(:work) { works(:kings) }

  describe "Relationships" do
    it "can have many votes" do
      expect(work.votes.count).must_equal 2
    end

    it "can have 0 votes" do
      work = Work.new(title: "Aladdin")
      expect(work.votes.count).must_equal 0
    end

    it "can access users through votes" do
      expect(work.users.length).must_be :>=, 0

      work.users.each do |user|
        expect(user).must_be_instance_of User
      end
    end
  end

  describe "Validations" do
    it "is valid when all fields are present" do
      expect(work).must_be :valid?
    end

    it "must have a title" do
      work.title = nil

      valid = work.valid?

      expect(valid).must_equal false
      expect(work.errors.messages).must_include :title
    end

    it "must have a unique title for the same category" do
      other_work = Work.new title: work.title, category: "book"
      other_work.save

      valid = other_work.valid?

      expect(valid).must_equal false
      expect(other_work.errors.messages).must_include :title
    end

    it "can have the same title for different categories" do
      other_work = Work.new title: work.title, category: "album"
      other_work.save

      valid = other_work.valid?

      expect(valid).must_equal true
    end
  end

  describe "Custom Methods" do
    describe "destroy_votes" do
      it "will destroy all votes that match a work_id" do
        work.destroy_votes
        expect(work.votes.count).must_equal 0
      end
    end

    describe "all_sorted" do
      it "will return a collection of works" do
        works = Work.all_sorted
        works.each do |work|
          expect(work).must_be_instance_of Work
        end
      end

      it "will return a collection of works sorted by number votes" do
        works = Work.all_sorted
        expect(works.first.votes.count).must_equal 2
        expect(works.last.votes.count).must_equal 1
      end

      it "will return a collection of works sorted alphabetically if there is a tie" do
        votes(:one).destroy
        votes(:four).destroy
        works(:kings).destroy
        works = Work.all_sorted
        expect(works.first.title).must_equal "Ask Bout Me"
        expect(works.last.title).must_equal "On Happiness Road"
      end

      it "will return an empty collection if there are no works" do
        works(:kings).destroy_votes
        works(:kings).destroy
        works(:happiness).destroy_votes
        works(:happiness).destroy
        works(:park).destroy_votes
        works(:park).destroy
        works = Work.all_sorted
        expect(works.length).must_equal 0
      end

      it "will still return a collection of works when all have no votes" do
        votes(:one).destroy
        votes(:two).destroy
        votes(:three).destroy
        votes(:four).destroy
        works = Work.all_sorted
        works.each do |work|
          expect(work.votes.count).must_equal 0
        end

        expect(works.length).must_be :>=, 0
      end
    end

    describe "by_category" do
      it "will return a collection of works with a specific category only" do
        works = Work.by_category("book")
        works.each do |work|
          expect(work).must_be_instance_of Work
          expect(work.category).must_equal "book"
        end
      end

      it "will return a collection of works in category sorted by number votes" do
        Work.create(title: "Grey Sister", category: "book")
        works = Work.by_category("book")
        expect(works.first.votes.count).must_equal 2
        expect(works.last.votes.count).must_equal 0
        expect(works.length).must_equal 2
      end

      it "will return a collection of works in category sorted alphabetically if there is a tie" do
        votes(:one).destroy
        votes(:four).destroy
        works(:kings).destroy
        Work.create(title: "Grey Sister", category: "book")
        Work.create(title: "Red Sister", category: "book")
        works = Work.by_category("book")
        works.each do |work|
          expect(work.votes.count).must_equal 0
        end
        expect(works.first.title).must_equal "Grey Sister"
        expect(works.last.title).must_equal "Red Sister"
      end

      it "will return an empty collection if there are no works in category" do
        votes(:two).destroy
        works(:happiness).destroy
        works = Work.by_category("movie")
        expect(works.length).must_equal 0
      end

      it "will still return a collection of works when all in category have no votes" do
        votes(:two).destroy
        works = Work.by_category("movie")
        expect(works.length).must_equal 1
      end
    end
  end
end
