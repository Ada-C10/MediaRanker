require "test_helper"
require 'pry'

describe Work do
  describe 'relations' do
    it 'has many votes' do
      work = works(:nemo)

      work.votes.length.must_equal 3
      work.votes[0].must_equal votes(:one)
    end
  end

  describe 'validations' do
    describe 'title' do
      it 'is valid when title is present' do
        is_valid = works(:nemo).valid?
        expect( is_valid ).must_equal true
      end

      it 'is invalid without a title' do
        w = Work.new(
          category: 'movie',
          title: nil,
          creator: 'Pixar',
          pub_year: 2001,
          description: 'daddy issues',
        )
        is_valid = w.valid?

        expect( is_valid ).must_equal false
        expect( w.errors.messages ).must_include :title
      end

      it 'is invalid with a non-unique title' do
        repeat = Work.new(
          category: 'movie',
          title: 'Finding Nemo',
          creator: 'Pixar',
          pub_year: 2001,
          description: 'daddy issues',
        )

        is_valid = repeat.valid?
        expect( is_valid ).must_equal false
        expect( repeat.errors.messages ).must_include :title
      end
    end

    describe 'creator' do
      it 'is valid when creator is present' do
        is_valid = works(:sunshine).valid?
        expect( is_valid ).must_equal true
      end

      it 'is invalid without a creator' do
        w = works(:sunshine)
        w.creator = nil
        is_valid = w.valid?

        expect( is_valid ).must_equal false
        expect( w.errors.messages ).must_include :creator
      end
    end

    describe 'category' do
      it 'is valid when category is present' do
        is_valid = works(:marie).valid?
        expect( is_valid ).must_equal true
      end

      it 'is invalid without a category' do
        w = works(:marie)
        w.category = nil
        is_valid = w.valid?

        expect( is_valid ).must_equal false
        expect( w.errors.messages ).must_include :category
      end
    end

    describe 'publication year' do
      it 'is valid when publication year is present' do
        is_valid = works(:heartburn).valid?
        expect( is_valid ).must_equal true
      end

      it 'is invalid without a publication year' do
        w = works(:heartburn)
        w.pub_year = nil
        is_valid = w.valid?

        expect( is_valid ).must_equal false
        expect( w.errors.messages ).must_include :pub_year
      end

      it 'is invalid if publication date is not an integer' do
        w = works(:heartburn)
        w.pub_year = '2018z'
        is_valid = w.valid?
        expect( is_valid ).must_equal false
        expect( w.errors.messages ).must_include :pub_year
      end

      it 'is invalid if publication date is greater than 2018' do
        w = works(:heartburn)
        w.pub_year = 2020
        is_valid = w.valid?

        expect( is_valid ).must_equal false
        expect( w.errors.messages ).must_include :pub_year
      end
    end
  end
end
