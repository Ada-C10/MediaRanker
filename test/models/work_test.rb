require 'test_helper'


describe Work do
  describe 'validations' do

    before do
      @work = Work.new(title: 'casper babypants', category: 'album')
    end

    it 'is valid when title and category are present' do
      is_valid = @work.valid?
      expect(is_valid).must_equal true
    end

    it 'is not valid without a title' do
      @work.title = nil
      is_valid = @work.valid?
      expect(is_valid).must_equal false
    end

    it 'is not valid without a category' do
      @work.category = nil
      is_valid = @work.valid?
      expect(is_valid).must_equal false
    end

    it 'is invalid if the title is not unique' do
      new_work = Work.new(title: "sound of music", category: "movie")
      is_valid = new_work.valid?
      expect(is_valid).must_equal false
    end
  end

  describe 'relations' do
    it 'each work can have many votes' do
      votes = Vote.where(work_id: "sound_of_music")
      expect(votes.count).must_equal 2
    end
  end
end
