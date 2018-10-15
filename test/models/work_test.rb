require "test_helper"

describe Work do
  # describe 'relations' do
  #   it 'a vote can be set through the method work' do
  #     vote = Vote.create!
  #     work = Work.new()
  #
  #     work.vote = vote
  #
  #     expect(vote.work).must_equal work
  #     epect(vote.work_id).must_equal work_id
  #   end
  # end

  describe 'Validations' do
    before do
      @work = Work.first
    end
    it 'is valid when title is present' do

      is_valid = @work.valid?

      expect(is_valid).must_equal true
    end

    it 'is invalid without a title' do
      @work.title = nil

      is_valid = @work.valid?

      expect(is_valid).must_equal false
      expect(@work.errors.messages).must_include :title
    end
    it 'is invalid with non-unique title' do

    end
  end
end
