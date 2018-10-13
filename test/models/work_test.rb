require "test_helper"

describe Work do
  let(:work) { Work.new }

  it "must be valid" do
    value(work).must_be :valid?
  end

  describe 'work_list' do
    it 'should return an array' do
      # Act
      works = Work.work_list

      # Assert
      expect(works).must_be_instance_of Array

      works.each do |work_array|
        current_work = Work.find(work_array[1])
        work_title = work_array[0]
        expect(work_title).must_equal current_work.title
      end
    end

    it 'should return an empty array when there are no works' do
      # Act
      Work.all.each do |work|
        work.votes.each do |vote|
          vote.destroy
        end

        work.destroy
      end
      works = Work.work_list

      # Assert
      expect(works).must_be_instance_of Array
      expect(works.length).must_equal 0
    end
  end

  describe "Presence of required attributes" do
    let(:work) { works(:book) } #arrange

    it "has required fields" do #act
      fields = [:category, :title, :creator, :published_year, :description]

      fields.each do |field| #assert
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
        expect(vote).must_be_instance of Vote
      end
    end

    it "can have many users through votes" #work has many users through votes
    #Arrange done with let

    #Act
    #work <== add user through votes
    #   works.votes.each do |vote|
    #     vote.each do |user_id|
    #       user_id
    # @work.users << User.find(user_id)
    #
    # user.works.select(vote.id)includes(:vote).each do |work|
    # vote = Work.vote
    #
    # user.vote_works.each do |vote_work|
    # vote_work.username


    #work <== add users through votes
    # @work.users << User.find(user_id)
    #Assert
    end 
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
