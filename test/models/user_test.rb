require "test_helper"

describe User do
  let(:user) { User.new }

  it "must be valid" do
    expect(user).must_be :valid?
  end

  it 'has required fields' do
    fields = [:name]

    fields.each do |field|
      expect(user).must_respond_to field
    end
  end

  describe 'validations' do
    it 'must have a name' do
      # Arrange
      user = users(:katherine)
      user.name = nil

      # Act
      #valid = book.valid?
      valid = name.save

      # Assert
      expect(valid).must_equal false
      expect(user.errors.messages).must_include :name
      expect(user.errors.messages[:name]).must_equal ["can't be blank", "is too short (minimum is 5 characters)"]
    end

    it 'must have a name with a min of 5 letters' do
      user.name = ''
      4.times do
        # Arrange
        user.name += 'a'

        # Act
        valid = user.valid?

        # Assert
        expect(valid).must_equal false
        expect(user.errors.messages).must_include :name
      end

      user.name += 'a'
      valid = user.valid?
      expect(valid).must_equal true
    end

    it 'requires a unique name' do
      #other_book = book.clone
      other_user = name(:fred)
      other_user.name = user.name

      valid = other_book.valid?

      expect(valid).must_equal false
      expect(other_book.errors.messages).must_include :name
    end
  end

end
