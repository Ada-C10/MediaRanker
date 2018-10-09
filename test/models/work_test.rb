require "test_helper"

describe Work do
  let(:work) { Work.new }

  it "must be valid" do
    value(work).must_be :valid?
  end

  describe 'validations' do
    it 'must have a category' do
    end

    it 'must have a title' do
    end

    it 'must have a creator' do
    end

    it 'must have a publication year' do
    end

    it 'must have a description' do
    end
  end

  describe 'relationships' do
  end

  describe 'movies_list' do
  end

  describe 'books_list' do
  end

  describe 'albums_list' do
  end
end
