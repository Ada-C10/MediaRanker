require "test_helper"

describe User do

  describe 'relations' do
    it 'has many votes' do
      user = users(:one)

      user.votes.length.must_equal 2
      user.votes[0].must_equal votes(:one)
    end
  end

  describe 'validations' do
    it 'is valid when username is present' do
      is_valid = users(:one).valid?
      expect( is_valid ).must_equal true

      is_valid = users(:three).valid?
      expect( is_valid ).must_equal true
    end

    it 'is invalid without a username' do
      w = users(:one)
      w.username = nil
      is_valid = w.valid?

      expect( is_valid ).must_equal false
      expect( w.errors.messages ).must_include :username
    end

    it 'is invalid with a non-unique username' do
      repeat = User.new(username: 'potato32')

      is_valid = repeat.valid?
      expect( is_valid ).must_equal false
      expect( repeat.errors.messages ).must_include :username
    end

    it 'is invalid with characters != a-z, 0-9, dash, and underscore' do
      x = User.new(username: '*abc')
      y = User.new(username: 'ABC')
      z = User.new(username: 'w h o o')
      tests = [x, y, z]

      tests.each do |test|
        is_valid = test.valid?
        expect( is_valid ).must_equal false
        expect( test.errors.messages ).must_include :username
      end
    end

    it 'is invalid with a username longer than 15 characters' do
      w = User.new(username: '123456789_foobar')

      is_valid = w.valid?
      expect( is_valid ).must_equal false
      expect( w.errors.messages ).must_include :username
    end
  end
end
