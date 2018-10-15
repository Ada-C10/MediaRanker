require "test_helper"

describe Work do
  let (:parable) { works(:parable) }
  let (:valid_nil) { works(:valid_nil) }
  let (:parable_album) { works(:parable_album) }
  let (:vote) do
    Vote.create!(user_id: users(:stevonnie).id, work_id: works(:parable).id)
  end


  describe 'Work validations' do
    it 'is valid when all required fields are present' do
      expect(valid_nil.valid?).must_equal true
    end

    it 'is invalid without a publication year' do
      valid_nil.publication = nil
      expect(valid_nil.valid?).must_equal false
      expect(valid_nil.errors.messages).must_include :publication
    end

    it 'is valid when title is not unique in different category (case-insensitive)' do
      expect(parable_album.valid?).must_equal true
    end

    it 'is invalid when title is not unique in same category (case-insensitive)' do
      parable_album.category = "book"
      expect(parable_album.valid?).must_equal false
      expect(parable_album.errors.messages).must_include :title
    end

    it 'is invalid when category is not included in valid categories array' do
      parable.category = "category"
      expect(parable.valid?).must_equal false
      expect(parable.errors.messages).must_include :category
    end

    it 'is invalid when publication year is not a valid integer' do
      invalid_years = [Date.today.year + 1, 0-Date.today.year]
      invalid_years.each do |year|
        parable.publication = year
        expect(parable.valid?).must_equal false
        expect(parable.errors.messages).must_include :publication
      end
    end
  end

  describe 'Work relations' do
    it 'can get votes with "votes"' do
      vote
      expect(parable.votes.ids).must_equal [vote.id]
    end

    it 'can get users with "users" through votes' do
      vote
      expect(parable.users.ids).must_equal [users(:stevonnie).id]
    end
  end

  describe 'Work model methods: listing and sorting' do
    it "most_recent_vote_date" do

    end

    it "self.sort_by_most_recent_vote(array_of_works)" do

    end

    it "self.list_all_works" do
    end

    it "self.list_top_works" do

    end
  end
end
