require "test_helper"

describe Work do


  describe 'validations' do
    before do
      # Arrange
      @work = works(:work_1)
    end

    it 'is valid when all fields are present' do
      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal true
    end

    it 'is valid when title is unique' do
      is_valid = @work.valid?
      expect( is_valid ).must_equal true
    end

    it 'is not valid when some fields are not present' do
      # Act
      work = works(:work_2)
      work.category = nil
      result = work.valid?

      # Assert
      expect(result).must_equal false
    end
  end

#confused by this :each

  describe 'relations' do
    it "has many votes" do
      w = Work.first
      votes = w.votes
      expect(votes).must_respond_to :each
    end
  end
end
