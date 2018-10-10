require "test_helper"

describe Work do
  let(:work) { works :cookies }

  it "must be valid" do
    expect(work).must_be :valid?
  end

  describe 'validations' do
    it 'must have a title' do
      work.title = nil
      # validations .valid? will run all validations
      valid = work.valid?
      # assert
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :title
    end
    it 'must have a creator' do
      work.creator = nil
      valid = work.valid?
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :creator
    end
    it 'must have a publication year' do
      work.publication_year = nil
      valid = work.valid?
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :publication_year
    end
    it 'must have a category' do
      work.category = nil
      valid = work.valid?
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :category
    end
  end
end
