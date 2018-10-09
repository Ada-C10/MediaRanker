require 'pry'
require 'test_helper'

describe Work do
  describe 'Validations' do
    let(:work) { Work.new }

    it 'is invalid when fields are left blank' do
      value(work.valid?).must_equal false
    end

    it 'is valid when all fields are present' do
      book = works(:book)

      value(book.valid?).must_equal true
    end

    it 'is invalid when the published field is not a number' do
      album = works(:album)
      album.published = "stringthing"
      album.save

      value(album.errors.messages).must_include :published
    end
  end

  describe 'Relationships' do
    it 'can have 0 or many votes' do
      book = works(:book)
      vote = votes(:vote1)
      vote2 = votes(:vote3)
      movie = works(:movie)

      expect(book.votes.length).must_be :>=, 2
      expect(movie.votes.length).must_be :>=, 0
      expect(book.votes.first).must_be_instance_of Vote
    end
  end

end
