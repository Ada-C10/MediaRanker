require "test_helper"

describe Work do
  let(:work) { works(:alanis) }

  it "must be valid" do
    value(work).must_be :valid?
  end

  it 'has required fields' do
    fields = [:title, :creator, :description, :year, :category]

    fields.each do |field|
      expect(work).must_respond_to field
  end
end

describe 'validations' do
  it 'must have a title' do
    # Arrange
    work = works(:alanis)
    work.title = nil

    # Act
    #valid = book.valid?
    valid = work.save

    # Assert
    expect(valid).must_equal false
    expect(work.errors.messages).must_include :title
    expect(work.errors.messages[:title]).must_equal ["can't be blank"]
  end

  it 'requires a unique title' do
    #other_book = book.clone
    other_work = works(:alanis)
    other_work.title = work.title

    valid = other_work.valid?

    expect(valid).must_equal false
    expect(other_work.errors.messages).must_include :title
  end

end
end
