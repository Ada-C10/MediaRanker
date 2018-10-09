require "test_helper"

describe Work do
  let(:work) { Work.new(title: 'test') }

  it "must be valid" do
    value(work).must_be :valid?
  end

  describe 'validations' do
    before do
      @work = Work.new(
        title: 'test title')
    end

    it 'is valid when title is present and unique' do

      is_valid = @work.valid?
      expect( is_valid ).must_equal true
    end
  end
end
