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
    expect(work.errors.messages[:title]).must_equal ["can't be blank", "has already been taken"]
  end
end
end
