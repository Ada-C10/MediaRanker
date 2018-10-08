require "test_helper"
require 'pry'
describe Work do
  let(:work) { Work.new }
  let(:secret) {works(:secret)}
  let(:remember) {works(:remember)}
  let(:billy) {works(:billy)}

  it "allows completely valid entries" do
    expect(remember.valid?).must_equal true
  end

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
