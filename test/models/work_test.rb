require "test_helper"

describe Work do
  let(:work) { Work.new }

  it "must be valid" do
    value(work).must_be :valid?
  end

  describe "Presence of required attributes" do

  it "has required fields" do
    fields = [:category, :title, :creator, :published_year, :description]

    fields.each do |field|
      expect(work).must_respond_to field
    end

  end

  describe "Relationships" do #work has many votes
    it "can have many votes"
    #Arrange done with let

    #Act
    work.votes << Vote.first
    votes = work.votes

    #Assert
    expect(votes).must_equal :>=, 1
    votes.each do |vote|
      expect(vote).must_be_instance of Integer
    end
  end

  it "can have many users through votes" #work belongs to user
  #Arrange done with let

  #Act
  #work <== add users through votes
  @work.users << User.find(user_id)

  user.works.select(vote.id)includes(:vote).each so |work|
  vote = Work.vote

  user.vote_works.each do |vote_work|
    vote_work.username


    #work <== add users through votes
    @work.users << User.find(user_id)
    #Assert
  end

  describe 'validations' do

    it "requires a unique title" do #for each category
      #Arrange
      new_work = Work.new title: work.title
      #Act
      new_work.valid?
      #Assert
      expect(new_work).must_equal false
      expect(new_work.errors.messages).must_include :title
    end
  end

  describe "Custom Method" do

    it "cannot recieve multiple votes from single user"
    #Arrange
    #Act
    user = User_id(id: 2)
    work = self.id(id: 22)
    @vote = Vote.id.include(user_id: 2, self.id: 22)

    #Assert
    expect(@vote).must_equal false
    expect(work.errors.messages).wont_include: user_id

    end
  end
end
