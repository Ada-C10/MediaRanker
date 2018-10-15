require "test_helper"

describe Work do
  let(:work) { works(:album1) }

  describe 'relations' do
      it 'has votes' do
        work.must_respond_to :votes
        expect(work.votes.first).must_be_kind_of Vote
      end
    end

  	describe 'validations' do

  		it 'is valid when title is present and unique to category' do
  			#act
  			is_valid = work.valid?

  			#assert
  			expect(is_valid).must_equal true
  		end

  		it 'is invalid without a title' do
  			work.title = nil

  			is_valid = work.valid?

  			expect(is_valid).must_equal false
  			expect(work.errors.messages).must_include :title
  		end

    it "will save if title is unique to category, but not overall" do
      work2 = Work.new(title: 'white album', category: 'book')

      is_valid = work2.valid?

      expect(is_valid).must_equal true
    end

  	it "won't save if title is a duplicate within category" do
  		work2 = Work.new(title: 'white album', category: 'album')

  		is_valid = work2.valid?

  		expect(is_valid).must_equal false

  	end


  end

  describe 'count votes (inherited)' do

      it 'accurately counts work votes' do
        low = works(:album1)
        high = works(:movie2)

        expect(low.count_votes).must_equal 1
        expect(high.count_votes).must_equal 2

      end
    end


  describe 'categorize works' do

      it 'returns only works from certain categories' do
        album_array = Work.categorize_works('album')
        expect(album_array.first.category).must_equal 'album'

        book_array = Work.categorize_works('book')
        expect(book_array.first.category).must_equal 'book'

        movie_array = Work.categorize_works('movie')
        expect(movie_array.first.category).must_equal 'movie'
      end
    end

    describe 'sort works' do

        it 'sorts works by most to least votes' do
          movie_array = Work.sort_works('movie')
          expect(movie_array.first).must_equal works(:movie2)
        end
      end

      describe 'generate top ten works' do

          it 'lists top ten works by vote and category' do
            titles =['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']

            10.times do |i|
              Work.create(title: titles[i], category: 'movie')
            end

              movie_array = Work.gen_top_ten_works('movie')

              expect(movie_array.length).must_equal 10
              expect(movie_array.first).must_equal works(:movie2)
          end
        end

        describe 'generate top work' do

            it 'determines which work had the most votes' do

                top_work = Work.gen_top_work

                expect(top_work).must_equal works(:movie2)
            end
          end
end
