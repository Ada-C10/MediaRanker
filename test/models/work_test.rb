require "test_helper"

describe Work do
  let(:work) {
      Work.new(
      title: 'test book',
      creator: 'test book',
      category: 'test book',
      description: 'test book',
      publication_year: 'test book',
    )
  }

  it "must be valid" do
    value(work).must_be :valid?
  end


  describe 'validations' do

    before do
      @work = Work.new(
        title: 'test book',
        creator: 'test book',
        category: 'test book',
        description: 'test book',
        publication_year: 'test book',
      )
    end

    it 'is valid when a title, creator, category, description and pub_year is present' do
      is_valid = @work.valid?
      expect( is_valid ).must_equal true
    end

    it 'is invalid without a title' do
      @work.title = nil
      is_valid = @work.valid?

      expect( is_valid ).must_equal false
      expect( @work.errors.messages ).must_include :title
    end

    it 'is invalid with a non-unique title' do
      @work.title = Work.first.title
      is_valid = @work.valid?

      expect( is_valid ).must_equal false
      expect( @work.errors.messages ).must_include :title
    end

  end


end
