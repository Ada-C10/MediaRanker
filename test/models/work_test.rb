require "test_helper"

describe Work do

  describe '' do
    it 'is valid when title is present' do
      work = Work.new(title: 'Some title')


      is_valid = work.valid?

      expect(is_valid).must_equal true
    end
  end
end
