require "test_helper"

describe User do
  let(:user) { users :coco }

  it "must be valid" do
    expect(user).must_be :valid?
  end

  describe 'validations' do
    it 'must have a name' do
      user.name = nil
      # validations .valid? will run all validations
      valid = user.valid?
      # assert
      expect(valid).must_equal false
      expect(user.errors.messages).must_include :name
    end
  end
    
end
