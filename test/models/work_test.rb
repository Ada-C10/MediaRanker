require "test_helper"

describe Work do
  describe 'Work validations' do
    before do
      @work = Work.new(title: 'test book', category: :album,
        creator: 'test creator', publication: 1700, description: nil)
    end

    it 'is valid when all required fields are present' do
      expect(@work.valid?).must_equal true
    end

    it 'is invalid without a publication year' do
      @work.publication = nil
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :publication
    end

    it 'is invalid unless title is unique (case-insensitive)' do
      @work.save!
      another_work = Work.new(title: 'TeSt bOoK', category: :album,
        creator: 'test creator', publication: 1700, description: nil)
        expect(another_work.valid?).must_equal false
        expect(another_work.errors.messages).must_include :title
    end

    it 'is invalid when category is not included in valid categories array' do
      VALID_WORK_CATEGORIES.each do |category|
        @work.category = category
        expect(@work.valid?).must_equal true
      end
      @work.category = "category"
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :category
    end

    it 'is invalid when publication year is not a valid integer' do
      year_inputs = [Date.today.year, Date.today.year + 1, 0-Date.today.year]
      expectations = [true, false, false]
      year_inputs.each_with_index do |year, index|
        @work.publication = year
        expect(@work.valid?).must_equal expectations[index]
        if expectations[index] == false
          expect(@work.errors.messages).must_include :publication
        end
      end
    end
  end

  describe 'Work relations' do
    before do
      @work = Work.create!(title: 'test book', category: :album,
        creator: 'test creator', publication: 1700, description: nil)
    end

    it 'can get votes with "votes"' do
      user = User.create!(name: 'test name')
      vote = Vote.create!(user_id: user.id, work_id: @work.id)
      expect(@work.votes.ids).must_equal [vote.id]
    end

    it 'can get users with "users" through votes' do
      user = User.create!(name: 'test name')
      expect(@work.users.ids).must_equal []
      vote = Vote.create!(user_id: user.id, work_id: @work.id)
      expect(@work.users.ids).must_equal [user.id]
    end
  end
end
