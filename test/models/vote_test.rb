require "test_helper"

describe Vote do
  describe 'Vote validations - presence' do
     before do
       # Arrange
       user = User.create(name: 'test name')
       work = Work.create(title: 'test book', category: :album,
                        creator: 'test creator', publication: 2018,
                        description: 'test description')
       @vote = Vote.create(user_id: user.id, work_id: work.id)
     end

     it 'is valid when all fields are present' do
       # Act
       result = @vote.valid?

       # Assert
       expect(result).must_equal true
     end
   end
end
