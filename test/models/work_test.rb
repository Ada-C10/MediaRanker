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

      end
    end


  end


end


