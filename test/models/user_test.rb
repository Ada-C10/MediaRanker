require "test_helper"
require 'pry'

describe User do
  let(:marshall) { users(:marshall) }
  let(:lily) { users(:lily) }
  let(:marshall_secret) {votes(:marshall_secret)}
  let(:billy) {works(:billy)}
  let(:secret) {works(:secret)}

  describe 'name validation' do
    it "must have a name" do
      expect(marshall.valid?).must_equal true

      marshall.name = nil
      expect(marshall.valid?).must_equal false

      marshall.name = "   "
      expect(marshall.valid?).must_equal false
    end

    it "must have a unique name" do
      expect(lily.valid?).must_equal true

      lily.name = 'Marshall'
      expect(lily.valid?).must_equal false
    end
  end

  describe 'a user has many votes' do

    it 'retrieves a list of votes' do
      expect(marshall.votes.count).must_equal 1
      expect(lily.votes.count).must_equal 2
    end

    it 'only retrieves votes for that user' do
      expect(lily.votes.all?{|vote| vote.user == lily}).must_equal true
    end

    it 'deletes votes if the user gets deleted' do  #can't actually delete a user in this implementation
      expect(Vote.select{|vote| vote.user == lily}.length).must_equal 2
      lily.destroy
      expect(Vote.select{|vote| vote.user == lily}.length).must_equal 0
    end

    it 'returns an empty collection if there are no votes' do
      expect(marshall.votes.count).must_equal 1
      marshall_secret.destroy
      expect(marshall.votes.count).must_equal 0
    end

    it 'adds a vote to the list each time a user votes' do
      expect(lily.votes.count).must_equal 2
      Vote.create(work: billy, user: lily)
      expect(lily.votes.count).must_equal 3
    end

    it 'will not add a vote for the same work more than once' do
      expect(lily.votes.count).must_equal 2
      Vote.create(work: secret, user: lily)
      expect(lily.votes.count).must_equal 2
    end
  end

  describe 'join date' do
    
    it 'formats the created_at date' do
      marshall.created_at = Date.parse('10/10/2010')
      expect(marshall.join_date).must_equal "Oct 10, 2010"
    end

  end

end
