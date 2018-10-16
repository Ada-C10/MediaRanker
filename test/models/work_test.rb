require "test_helper"

describe Work do
  let (:work) { works(:parable) }
  let (:parable) { works(:parable) }
  let (:deluxe) { works(:deluxe) }
  let (:parable_album) { works(:parable_album) }
  let (:circa) { works(:circa) }
  let (:onion) { users(:onion) }
  let (:burnbook) { works(:burnbook) }
  let (:hp) { works(:hp) }
  let (:works_hash) { Work.list_all_works }
  let (:poodr) { works(:poodr) }

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
    describe 'most recent vote date' do
      it "work.most_recent_vote_time returns the youngest vote" do
        # Create a new vote -> expect most recent vote to be today's
        time_now = Time.zone.now
        Vote.create!(user: onion, work: parable, created_at: time_now)
        expect(Work.find_by(title: "Parable of the Sower").most_recent_vote_time).must_equal time_now
      end

# Edge case: a tie
    it "returns a single date even when multiple votes have the exact same created_at time" do
      expect(deluxe.most_recent_vote_time).must_equal Time.zone.parse("1 Jan 2018 12:00:00 PST -08:00")
    end

# Edge case: work has no votes
      it "most_recent_vote_time returns a specific, ancient date for a work with no votes" do
        expect(parable_album.most_recent_vote_time).must_equal Time.new(0)
      end
    end

    describe 'self.by_category(category)' do
      it 'orders each category alphabetically' do
        require Rails.root.join('test', 'helpers', 'use_seeds.rb')

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
      # EDGE: there are no works in that category
    end

    describe 'self.sort(array_of_works)' do

   # 1. number of votes (descending)
   # 2. date of most recent vote (descending)
   # 3. title (ascending)

      it "Nominal: the method sorts Book / Book Votes fixture data correctly" do
        expected_order = [parable, burnbook, hp, poodr]
        expected_order.each_with_index do |title, index|
          expect(works_hash["book"][index]).must_equal title
        end
      end

      it "Nominal: sorts test(seed) and fixture data correctly" do
        # Load seed data into the test environment
        require Rails.root.join('test', 'helpers', 'use_seeds.rb')

        VALID_WORK_CATEGORIES.each do |category|
          last_index = works_hash[category].length-1

          works_hash[category].each_with_index do |work, index|
            if index < last_index
              next_work = works_hash[category][index+1]
              expect(work.votes.size).must_be :>=, next_work.votes.size

              if work.votes.count == next_work.votes.count
                expect(work.most_recent_vote_time).must_be :>=, next_work.most_recent_vote_time

                if work.most_recent_vote_time == next_work.most_recent_vote_time
                  expect(work.title).must_be :<=, next_work.title
                end

              end
            end

          end
        end

      end

      # Edge: a work has no votes (is most recent vote time pushed to end?)
      # Edge: there are no works
    end


    describe 'self.list_all_works' do
      it "Nominal: creates a hash where sorted arrays of works are grouped by category" do

      end
      # Edge: returns empty hash if there are no works
    end

    describe 'self.top_ten(sorted_hash)' do
      it "does what i want" do

      end
  # Nominal: it returns 10 or fewer votes in each hash
  # Nominal: all of the votes have at least one vote
  # edge: it returns empty hash if there are no votes
    end

    describe 'self.spotlight' do
      it "does what i want" do

      end
      # Edge case: there are no votes in any category returns nil
      # Edge case: all #1 works in all categories have the same
                    # title, vote date, and number of votes
      # Edge case:
    end

  end
end
