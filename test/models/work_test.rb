require "pry"
require "test_helper"

describe Work do
  describe 'validations' do
    let(:work) { Work.new }

    it "is invalid when fields are left blank" do
      value(work.valid?).must_equal false
    end

    it "is valid when all fields are present" do
      book = works(:book)

      value(book.valid?).must_equal true
    end

    it "is invalid when the published field is not a number" do
      album = works(:album)
      album.published = "stringthing"
      album.save

      value(album.errors.messages).must_include :published
    end
  end

  describe 'relations' do


  end
end
