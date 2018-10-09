require "test_helper"

describe Work do
  it 'must instantiate a valid book' do
    work = Work.new(title: "a work")
    is_valid = work.valid?
    expect(is_valid).must_equal true
  end

  describe 'validations' do
    it 'is valid when a title is present' do

    # messages = :book_example.errors.messages
    # expect(messages).must_equal []
    end
    it 'is is invalid without a title' do
    end
    it 'is invalid if category is not book, movie, or album' do
    end
  end
end
