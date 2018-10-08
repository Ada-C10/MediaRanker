require "test_helper"

describe Work do
  describe 'Work validations' do
     before do
       # Arrange
       # @user = User.new(name: 'test name')
       @work = Work.new(title: 'test book', category: :album,
                        creator: 'test creator', publication: 1234,
                        description: nil)
       # @vote = Vote.new(user_id: @user.id, work_id: @work.id)
     end

     it 'is valid when all fields are present' do
       # Act
       result = @work.valid?

       # Assert
       expect(result).must_equal true
     end
   end
end
