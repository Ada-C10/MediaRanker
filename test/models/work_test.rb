require "test_helper"

describe Work do



  describe 'validations' do

    before do
      @work = Work.new(title: 'valid work')
    end

    it 'is valid when title is present and unique' do

      #act
      is_valid = @work.valid?

      #assert
      expect( is_valid ).must_equal true
    end


    it 'is invalid without a title' do

      @work.title = nil

      is_valid = @work.valid?

      expect( is_valid ).must_equal false
      expect( @work.errors.messages ).must_include :title
    end


    it 'is invalid with a non-unique title' do
      work2 = Work.new(title: @work.title)

      is_valid = work2.valid?

      # expect( is_valid ).must_equal false
    end





  end


  describe 'relations' do

  #   it 'can set a vote through the method "vote"' do
  #   vote = 1
  #   work = Work.new(title: 'test work')
  #
  #   work.vote = vote
  #
  #   expect( work.vote ).must_equal vote
  #   expect( work.vote_id ).must_equal work.vote_id
  # end


  it "Has some votes" do
    work = Work.first

    votes = work.votes

    expect(votes).must_respond_to :each
  end

end

  #works must have a method that is part of the relationship to votes
  #must have a .votes method

  #work that doesn't have a title is not valid
  #work with nil title or not provided will
  #when calling .valid? will return false

  #a work that has a non-unique title is not valid
  #there is an instance of work a
  #there is an instance of work b with the same title
  #calling .valid? on second book will return false




end
