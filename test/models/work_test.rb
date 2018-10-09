require "test_helper"

describe Work do
  let(:work) { Work.new }

  it "must be valid" do
    value(work).must_be :valid?
  end

  # describe 'relations' do
  #
  #   # Works must have a method that is part of the relationship to vote and returns the expected thing from the method
  #   # it has a .votes method, it returns a collection of votes
  #
  #   it 'has a collection of votes'
  #
  # end

end
