require "test_helper"

describe Work do
  let(:work) { works(:one) }

  it "must be valid" do
    expect(work).must_be :valid?
  end

  it 'has required fields' do
    fields = [:category, :title, :creator, :publication_year, :description ]

    fields.each do |field|
      expect(work).must_respond_to field
    end
  end


end
