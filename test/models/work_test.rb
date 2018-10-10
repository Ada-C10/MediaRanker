require "test_helper"

describe Work do
  let(:work) { Work.new }

  it "must be valid" do
    value(work).must_be :valid?
  end

  describe 'validation' do

    it 'is valid when all fields are present' do
      work = works(:treat)

      result = work.valid?
      expect(result).must_equal true
    end

  end

end
