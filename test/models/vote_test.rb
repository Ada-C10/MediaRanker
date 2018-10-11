require "test_helper"

describe Vote do
  let(:marshall_secret) {votes(:marshall_secret)}
  let(:marshall) {users(:marshall)}
  let(:secret) {works(:secret)}
  let(:billy) {works(:billy)}

  describe 'relationships' do
    it "allows a valid vote" do
      expect(marshall_secret.valid?).must_equal true
    end

    it "validates uniqueness of user voting for the same work" do
      same_vote = Vote.create(user: marshall, work: secret)
      expect(same_vote.valid?).must_equal false
    end

    it "creates new votes and adds to the total vote count" do
      expect(Vote.all.count).must_equal 3

      Vote.create(user: marshall, work: billy)
      expect(Vote.all.count).must_equal 4
    end

    it "must have a user in the database" do
      bad_vote = Vote.new(work: billy)
      expect(bad_vote.valid?).must_equal false

      bad_vote = Vote.new(user_id: 5, work: billy)
      expect(bad_vote.valid?).must_equal false
    end

    it "must have a work in the database" do
      bad_vote = Vote.new(user: marshall)
      expect(bad_vote.valid?).must_equal false

      bad_vote = Vote.new(user: marshall, work_id: 5)
      expect(bad_vote.valid?).must_equal false
    end

    it "does not destroy user or work if vote is destroyed" do #can only destroy a vote by destroying its work in this implementation
      marshall_secret.destroy
      expect(marshall.valid?).must_equal true
      expect(secret.valid?).must_equal true
    end

    it "retrieves its own user" do
      expect(marshall_secret.user).must_equal marshall
    end

    it "retrieves its own work" do
      expect(marshall_secret.work).must_equal secret
    end
  end

  describe 'upvote date' do

    it 'formats the created_at date' do
      marshall_secret.created_at = Date.parse('10/10/2010')
      expect(marshall_secret.upvote_date).must_equal "Oct 10, 2010"
    end

  end
end
