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

    it 'votes related to a work are destroyed when a work is deleted' do

    #test that votes related to a work are destroyed when work is deleted
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

      expect(Work.get_media("album").length).must_equal 3
      expect(Work.get_media("album").first).must_be_instance_of Work
      expect(Work.get_media("album").first.title).must_equal "Lorem Ipsum"
    end
  end

  describe 'Work#top_ten' do
    it "will return collection of 10 works of given category organized by votes" do

      12.times do
        Work.create(title: "Test thing", creator: "Fox Corp.", published: 2004, description: "Blah blah blah", category: "album")
      end

      expect(Work.top_ten("album").length).must_equal 10
      expect(Work.top_ten("album").first.category).must_equal "album"
      expect(Work.top_ten("album").first.title).must_equal "Lorem Ipsum"
      expect(Work.top_ten("album").second.title).must_equal "Queen Of The Damned Soundtrack"
      #This work has no votes, but still shows up (edge case)
      expect(Work.top_ten("album").last.title).must_equal "Test thing"
    end

    it "will return an empty collection if there are no works for a category" do
      expect(Work.top_ten("pineapple").length).must_equal 0
      expect(Work.top_ten("pineapple")).must_be_empty
    end
  end

  describe 'Work#top_work' do
    it "will return the work with the most votes" do

      expect(Work.top_work.title).must_equal "The Alchemist"
      expect(Work.top_work).must_be_instance_of Work
    end
  end

end
end
