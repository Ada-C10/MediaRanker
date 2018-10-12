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

  describe 'Work#get_media' do
    it "will return collection of given category of work sorted by vote" do
      album = works(:album)
      album2 = works(:album2)
      album3 = works(:album3)
      vote2 = votes(:vote2)
      vote4 = votes(:vote4)
      vote5 = votes(:vote5)

      expect(Work.get_media("album").length).must_equal 3
      expect(Work.get_media("album").first).must_be_instance_of Work
      expect(Work.get_media("album").first.title).must_equal "Lorem Ipsum"
    end
  end

  describe 'Work#top_ten' do
    it "will return collection of 10 works of given category" do
      album = works(:album)
      album2 = works(:album2)
      album3 = works(:album3)

      # expect(Work.top_ten("album").length).must_equal 10
      # expect(Work.top_ten("album").first.category).must_equal "album"
      # expect(Work.top_ten("album").first.title).must_equal "Lorem Ipsum"
      # expect(Work.top_ten("album").last.title).must_equal "Lorem Ipsum"
    end

  end

  describe 'Work#top_work' do
    it "will return the work with the most votes" do
      book = works(:book)
      album = works(:album)
      movie = works(:movie)
      movie2 = works(:movie2)
      album2 = works(:album2)
      album3 = works(:album3)
    end
  end


end

# def self.get_media(type)
#   works = Work.all.where(category: type)
#   works.sort_by {|work| work.votes.count}.reverse!
# end
