require "test_helper"

describe Work do
  let (:work) { works(:parable) }
  let (:parable) { works(:parable) }
  let (:deluxe) { works(:deluxe) }
  let (:parable_album) { works(:parable_album) }
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
      expect(work.users).must_equal User.where.not(name: "onion")
    end
  end

  describe 'Work model methods: listing and sorting' do
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

    it "self.list_all_works" do
      
    end

    it "self.list_top_works" do

    end
  end
end
