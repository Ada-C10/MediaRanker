require "test_helper"

describe Work do
  let(:work) { works :cookies }

  it "must be valid" do
    expect(work).must_be :valid?
  end

  describe 'validations' do
    it 'must have a title' do
      work.title = nil
      # validations .valid? will run all validations
      valid = work.valid?
      # assert
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :title
    end
    it 'must have a creator' do
      work.creator = nil
      valid = work.valid?
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :creator
    end
    it 'must have a publication year' do
      work.publication_year = nil
      valid = work.valid?
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :publication_year
    end
    it 'must have a category' do
      work.category = nil
      valid = work.valid?
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :category
    end

    describe 'relationships' do
      it 'has votes' do
        expect(work.votes.any?).must_equal true
      end

      it 'increments votes' do
        work.votes << Vote.last

        votes = work.votes

        expect(votes.length).must_equal 3
        votes.each do |vote|
          expect(vote).must_be_instance_of Vote
        end
      end
    end

    describe 'caching' do
      it 'accurately caches vote tally' do
      expect(work.votes.count).must_equal work.votes_count
      end

      it 'increments votes_count' do
        w = works (:i_like_that)
        u = users(:coco)
        w.votes.create(user_id: u.id)
        expect(w.votes.count).must_equal 1
        expect(w.votes_count).must_equal w.votes.count
      end
    end

    describe 'top' do
      it 'returns works with votes counts in descending order' do
        10.times do
          work = create(:work)
        end

        top_movies = Work.top?("movie")

        expect(top_movies.count).must_equal 10
        expect(top_movies.first.votes_count).must_be :>, top_movies.last.votes_count
      end
      it 'returns an empty array if no works in a category' do
        albums = Work.where(category: "album")
        albums.destroy_all

        top_albums = Work.top?("album")
        expect(top_albums).must_be_empty
        expect(top_albums).must_be_instance_of Array
      end
    end

    describe 'spotlight' do
      it 'randomly selects a work' do
        10.times do
          work = create(:work)
        end

        # implement a handful of runs to make sure the same works are not
        # being selected
        work1 = Work.spotlight?
        work2 = Work.spotlight?
        work3 = Work.spotlight?
        work4 = Work.spotlight?
        work5 = Work.spotlight?

        expect(work1).wont_equal work2
        expect(work2).wont_equal work3
        expect(work3).wont_equal work4
        expect(work4).wont_equal work5
        expect(work1).must_be_instance_of Work

      end
    end
  end
end


