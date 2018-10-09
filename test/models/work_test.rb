require "test_helper"

describe Work do

  # describe 'relations' do
  #     it 'can set the author through "author"' do
  #       # Create two models
  #       author = Author.create!(name: "test author") #! saves it to db
  #       book = Book.new(title: "test book")
  #
  #       # Make the models relate to one another
  #       book.author = author
  #
  #       # author_id should have changed accordingly
  #       expect(book.author_id).must_equal author.id
  #     end
  #
  #     it 'can set the author through "author_id"' do
  # # NOTE: WE DO THIS BELOW WITH FIXTURES
  #       # Create two models
  #       author = Author.create!(name: "test author")
  #       book = Book.new(title: "test book")
  #
  #       # Make the models relate to one another
  #       book.author_id = author.id
  #
  #       # author should have changed accordingly
  #       expect(book.author).must_equal author
  #     end
  #   end

  	describe 'validations' do
      let(:work) { works(:album1) }

  		it 'is valid when title is present and unique' do
  	# NOTE: WE DO THIS BELOW WITH FIXTURES

  			#act
  			is_valid = work.valid?

  			#assert
  			expect(is_valid).must_equal true
        #TODO: test unique!!
  		end

  		it 'is invalid without a title' do
  			work.title = nil

  			is_valid = work.valid?

  			expect(is_valid).must_equal false
  			expect(work.errors.messages).must_include :title
  		end

  	it "won't save if it's a duplicate" do
  		work2 = Work.new(title: 'white album')

  		is_valid = work2.valid?

  		expect(is_valid).must_equal false

  	end


  end
end
