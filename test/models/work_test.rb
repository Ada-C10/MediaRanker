require "test_helper"

# describe Work do
#   let(:work) { Work.new }
#
#   it "must be valid" do
#     value(work).must_be :valid?
#   end

describe Work do
  describe 'validations' do
    before do
      @work = Work.new(title: 'test work', publication_year: 2018, description: 'some description', creator: 'some creator', category: 'movie')
    end

    it 'is valid when all fields are present' do
      valid_work = @work.valid?

      expect(valid_work).must_equal true
    end

    it 'is invalid without a title' do
      @work.title = nil
      result = @work.valid?
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :title
    end

  end
end
