require "test_helper"

describe User do
  let(:user) { users(:cassy) }
  describe 'validations' do
    before do

      # Arrange - Create valid user

    end
      # Does it pass with all fields?
      it 'is valid when all fields are present' do
        #Act
        result = user.valid?

        # Assert
        expect(result).must_equal true
      end
      # Does it fail if name is missing?
      it 'is invalid without a name' do
        # Arrange
        user.name = nil

        # Act
        result = user.valid?

        #Assert
        expect(result).must_equal false
        expect(user.errors.messages).must_include :name

      end

      # Does it fail if there's a duplicate name?
      it 'requires a unique name' do
        other_user = users(:jane)
        other_user.name = user.name
        valid = other_user.valid?
        expect(valid).must_equal false
        expect(other_user.errors.messages).must_include :name
      end
      # Can you access the name property?

  end

  describe 'relations' do

  end

  describe 'custom methods' do

  end
end
