require "test_helper"

describe Work do
  let (:work) { works(:parable) }
  let (:parable) { works(:parable) }
  let (:deluxe) { works(:deluxe) }
  let (:parable_album) { works(:parable_album) }
  let (:circa) { works(:circa) }
  let (:onion) { users(:onion) }

  describe 'Work validations' do
    it 'work fixtures demonstrate which fields are required' do
      # works are valid when all required fields are present
      # even for nil description, or duplicate title in different category
      Work.all.each { |work| expect(work.valid?).must_equal true }
    end

    it 'is invalid without required fields' do
      required_fields = [:title=, :category=, :creator=, :publication=]
      required_fields.each do |field|
        work.send field, nil
        expect(work.valid?).must_equal false
        field = field.to_s.chop.to_sym
        expect(work.errors.messages).must_include field
      end
    end

    it 'is invalid when title is not unique in same category (case-insensitive)' do
      parable_album.category = "book"
      expect(parable_album.valid?).must_equal false
      expect(parable_album.errors.messages).must_include :title
    end

    it 'is invalid when category is not included in valid categories array' do
      work.category = "category"
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :category
    end

    it 'is invalid when publication year is not a valid integer' do
      [999999, 0, -1, 1000.1].each do |year|
        work.publication = year
        expect(work.valid?).must_equal false
        expect(work.errors.messages).must_include :publication
      end
    end
  end

  describe 'Work relations' do
    it 'can get votes with \"work.votes\"' do
      expect(work.votes).must_equal Vote.where(work: work)
    end

    it 'can get users with \"work.users\" (through votes)' do
      expect(work.users).must_equal User.where.not(name: "onion").where.not(name: "lars-of-the-stars")
    end
  end

  describe 'Work model methods: listing and sorting' do
    describe 'Helper methods' do
      it "most_recent_vote_date returns the youngest vote" do
        # Create a new vote -> expect most recent vote to be today's
        Vote.create!(user: onion, work: parable)
        expect(Work.find_by(title: "Parable of the Sower").most_recent_vote_date.to_date).must_equal Date.today
      end

      it "most_recent_vote_date returns a specific, ancient date for a work with no votes" do
        expect(parable_album.most_recent_vote_date).must_equal Date.jd(0)
      end

      it "#self.sort_by_most_recent_vote correctly sorts in ascending order" do
        # Create a new vote today:
        Vote.create!(user: onion, work: deluxe)
        sorted_works = Work.sort_by_most_recent_vote(Work.all.to_a)

        sorted_works.each_with_index do |work, index|
          if index < sorted_works.length - 1
            expect(work.most_recent_vote_date).must_be :<=, sorted_works[index+1].most_recent_vote_date
          else
            expect(work.most_recent_vote_date.to_date).must_equal Date.today
          end
        end
      end
    end

    describe 'self.by_category(category)' do
      it 'returns an Array' do
        require Rails.root.join('test', 'helpers', 'use_seeds.rb')
        puts "Number of works: #{Work.count}"
        VALID_WORK_CATEGORIES.each do |category|
          ordered_works = Work.by_category(category)

          ordered_works.each_with_index do |work, index|
            last_index = ordered_works.size-1
            if index < last_index
              next_work = ordered_works[index+1]
              expect(work.title).must_be :<=, next_work.title
            end
          end
        end

      end
    end

    describe 'self.list_all_works' do
      let(:works_hash){Work.list_all_works}
      # after .reverse!, the final sort order is:
      # 1. most to fewest votes,
      # 2. newest to oldest vote,
      # 3. A to Z (by title)
      it "orders correctly" do
        # make all of the works a book except parable_album
        [deluxe, circa].each do |work|
          work.category = "book"
          work.save!
        end

        expected_order = [deluxe, parable, circa]
        expected_order.each_with_index do |title, index|
          expect(works_hash["book"][index]).must_equal title
        end
      end

      it "sorts test(seed) data correctly" do
        skip

        require Rails.root.join('test', 'helpers', 'use_seeds.rb')

        hash_keys = ["album", "book", "movie"]
        expect(works_hash.keys).must_equal hash_keys

        works_hash = Work.list_all_works

        works_hash["book"].each do |book|
          p book.votes.count
          p book.title
        end

        hash_keys.each do |category|
          last_index = works_hash[category].length-1

          works_hash[category].each_with_index do |work, index|
            if index < last_index
              next_work = works_hash[category][index+1]
              expect(work.votes.size).must_be :>=, next_work.votes.size

              if work.votes.count == next_work.votes.count
                expect(work.most_recent_vote_date).must_be :>=, next_work.most_recent_vote_date

                if work.most_recent_vote_date == next_work.most_recent_vote_date
                  expect(work.title).must_be :<=, next_work.title
                end

              end
            end

          end
        end

      end
    end


    describe 'self.list_top_works' do
      it "does what i want" do

      end
    end
  end
end
