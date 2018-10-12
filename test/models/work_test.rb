require "test_helper"

describe Work do
  let(:work) { works(:treat) }

  it "must be valid" do
    value(work).must_be :valid?
  end

  describe 'Validations' do

    it 'is valid when all fields are present' do
      result = work.valid?
      expect(result).must_equal true
    end

    it 'it has required fields' do
      fields = [:title, :creator, :category, :publication_year, :description]

      fields.each do |field|
        expect(work).must_respond_to field
      end
    end

    it 'is not valid when the title of the media is not unique' do
      work_copy = work.dup

      assert_not work_copy.valid?
    end

  end

  describe 'Relationships' do

  end

end
