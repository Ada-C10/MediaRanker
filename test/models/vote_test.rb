require "test_helper"

describe Vote do

  describe 'relations' do

    before do
      @vote = Vote.new
    end

    it 'can set the medium through "medium_id"' do
      @vote.medium_id = media(:one).id

      expect( @vote.medium_id ).must_equal media(:one).id
      expect( @vote.medium ).must_equal media(:one)
    end

    it 'can set the medium through "medium"' do
      @vote.medium = media(:one)

      expect( @vote.medium ).must_equal media(:one)
      expect( @vote.medium_id ).must_equal media(:one).id
    end

    it 'can set the user through "user_id"' do
      @vote.user_id = users(:one).id

      expect( @vote.user_id ).must_equal users(:one).id
      expect( @vote.user ).must_equal users(:one)
    end

    it 'can set the user through "user"' do
      @vote.user = users(:one)

      expect( @vote.user_id ).must_equal users(:one).id
      expect( @vote.user ).must_equal users(:one)
    end

  end

end
