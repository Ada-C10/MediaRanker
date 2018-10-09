require "test_helper"
require 'pry'
describe Work do
  let(:secret) {works(:secret)}
  let(:remember) {works(:remember)}
  let(:billy) {works(:billy)}

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

  describe 'custom method: books' do
    it 'returns a collection if there are books in the database' do
      expect(Work.books).must_be_instance_of Array
    end

    it 'returns an empty collection if there are no books' do

    end

  end

  describe 'custom method: albums' do


  end

  describe 'custom method: movies' do


  end
end
