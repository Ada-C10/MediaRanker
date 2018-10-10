require "test_helper"
require 'pry'

describe Work do
  let(:secret) {works(:secret)}
  let(:remember) {works(:remember)}
  let(:billy) {works(:billy)}
  let(:marshall_billy) {votes(:marshall_billy)}
  let(:media_categories) {['movie', 'book', 'album']}

  it "allows completely valid entries" do
    expect(remember.valid?).must_equal true
  end

  describe "category validation" do
    it "only allows valid categories" do
      expect(secret.valid?).must_equal true  #book
      expect(remember.valid?).must_equal true  #album
      expect(billy.valid?).must_equal true  #movie

      secret.category = nil
      expect(secret.valid?).must_equal false

      secret.category = 1
      expect(secret.valid?).must_equal false

      secret.category = 'marshmallow'
      expect(secret.valid?).must_equal false
    end
  end

  describe "publication_year validation" do
    it "allows publication_year to be blank" do
      expect(billy.valid?).must_equal true

      billy.publication_year = nil
      expect(billy.valid?).must_equal true

      billy.publication_year = ""
      expect(billy.valid?).must_equal true

      billy.publication_year = " "
      expect(billy.valid?).must_equal true

      billy.publication_year = "        "
      expect(billy.valid?).must_equal true
    end

    it "only allows publication_year between 1000 and current year" do
      expect(billy.valid?).must_equal true

      billy.publication_year = 'a word'
      expect(billy.valid?).must_equal false

      billy.publication_year = 0
      expect(billy.valid?).must_equal false

      billy.publication_year = 3035
      expect(billy.valid?).must_equal false

      billy.publication_year = 999
      expect(billy.valid?).must_equal false

      billy.publication_year = 1000
      expect(billy.valid?).must_equal true

      billy.publication_year = 2018
      expect(billy.valid?).must_equal true

      billy.publication_year = Date.today.year
      expect(billy.valid?).must_equal true
    end
  end

  describe "title validation" do
    it "checks for unique titles within categories" do
      #copy secret's title and category
      secret_copy = Work.new( title: secret.title,
                              category: secret.category,
                              creator: 'someone else',
                              publication_year: 1111,
                              description: 'a fake book')
      expect(secret_copy.valid?).must_equal false
      expect(secret_copy.errors.messages).must_include :title

      #copy secret's title, but use a different category
      billy.title = secret.title
      expect(billy.valid?).must_equal true
    end

    it "must have a title" do
      remember.title = nil
      expect(remember.valid?).must_equal false
      expect(remember.errors.messages).must_include :title

      remember.title = " "
      expect(remember.valid?).must_equal false
      expect(remember.errors.messages).must_include :title
    end
  end

  describe 'custom method: list(media_category) for books' do

    it 'returns an array if there is only one book' do
      expect(Work.list('book')).must_be_instance_of Array
      expect(Work.list('book').length).must_equal 1
      expect(Work.list('book').first.category).must_equal 'book'
    end

    it 'returns a collection if there are books in the database' do
      remember.update(category: 'book')
      billy.update(category: 'book')
      expect(Work.list('book')).must_be_instance_of Array
      expect(Work.list('book').length).must_equal 3
      expect(Work.list('book').all?{|work| work.category = 'book'}).must_equal true
    end

    it 'returns an empty collection if there are no books' do
      secret.update(category: 'album')
      expect(Work.list('book')).must_be_instance_of Array
      expect(Work.list('book').length).must_equal 0
    end

  end

  describe 'custom method: list(media_category) for albums' do

        it 'returns an array if there is only one album' do
          expect(Work.list('album')).must_be_instance_of Array
          expect(Work.list('album').length).must_equal 1
          expect(Work.list('album').first.category).must_equal 'album'
        end

        it 'returns a collection if there are albums in the database' do
          secret.update(category: 'album')
          billy.update(category: 'album')
          expect(Work.list('album')).must_be_instance_of Array
          expect(Work.list('album').length).must_equal 3
          expect(Work.list('album').all?{|work| work.category = 'album'}).must_equal true
        end

        it 'returns an empty collection if there are no albums' do
          remember.update(category: 'book')
          expect(Work.list('album')).must_be_instance_of Array
          expect(Work.list('album').length).must_equal 0
        end

  end

  describe 'custom method: movies' do

    it 'returns an array if there is only one movie' do
      expect(Work.list('movie')).must_be_instance_of Array
      expect(Work.list('movie').length).must_equal 1
      expect(Work.list('movie').first.category).must_equal 'movie'
    end

    it 'returns a collection if there are movies in the database' do
      remember.update(category: 'movie')
      secret.update(category: 'movie')
      expect(Work.list('movie')).must_be_instance_of Array
      expect(Work.list('movie').length).must_equal 3
      expect(Work.list('movie').all?{|work| work.category = 'movie'}).must_equal true
    end

    it 'returns an empty collection if there are no movies' do
      billy.update(category: 'album')
      expect(Work.list('movie')).must_be_instance_of Array
      expect(Work.list('movie').length).must_equal 0
    end
  end

  describe 'top_ten' do
    it 'returns exactly 10 records if there are at least 10 in db' do
      media_categories.each do |category|
        15.times do
          Work.create(category: category, title: rand(0..999999))
        end
        expect(Work.top_ten(category).count).must_equal 10
      end
    end

    it 'returns all of the records if there are fewer than 10 in db' do
      media_categories.each do |category|
        expect(Work.top_ten(category).count).must_equal 1
      end
    end

    it 'returns an empty list if there are no records in db' do
      secret.destroy
      remember.destroy
      billy.destroy
      media_categories.each do |category|
        expect(Work.top_ten(category).empty?).must_equal true
      end
    end
  end

  describe 'media_lists' do

    let(:lists) {Work.media_lists}

    it 'returns an array of arrays' do
      expect(lists).must_be_instance_of Array
      lists.each do |list|
        expect(list).must_be_instance_of Array
        expect(list.count).must_equal 1   #1 of each category in fixtures
      end
    end

    it 'returns an array of empty arrays if there are no works' do
      secret.destroy
      remember.destroy
      billy.destroy

      expect(lists).must_be_instance_of Array

      lists.each do |list|
        expect(list).must_be_instance_of Array
        expect(list.empty?).must_equal true   #0 of each category in fixtures
      end
    end
  end

  describe 'top_ten_lists' do
    let(:lists) {Work.top_ten_lists}
    it 'returns an array of arrays' do
      expect(lists).must_be_instance_of Array
      lists.each do |list|
        expect(list).must_be_instance_of Array
        expect(list.count).must_equal 1   #1 of each category in fixtures
      end
    end

    it 'returns an array of empty arrays if there are no works' do
      secret.destroy
      remember.destroy
      billy.destroy

      expect(lists).must_be_instance_of Array

      lists.each do |list|
        expect(list).must_be_instance_of Array
        expect(list.empty?).must_equal true   #0 of each category in fixtures
      end
    end
  end

  describe 'a work has many votes' do
    it 'retrieves a list of votes' do
      expect(secret.votes.count).must_equal 2
    end

    it 'only retrieves votes for that work' do
      expect(secret.votes.all?{|vote| vote.work == secret}).must_equal true
    end

    it 'deletes votes if the work gets deleted' do
      expect(Vote.select{|vote| vote.work == secret}.length).must_equal 2
      secret.destroy
      expect(Vote.select{|vote| vote.work == secret}.length).must_equal 0
    end

    it 'returns an empty collection if there are no votes' do
      expect(billy.votes.count).must_equal 0
    end

  end

end
