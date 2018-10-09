require "test_helper"

describe Vote do
  describe 'Vote validations - presence' do
     before do
       @user = User.create!(name: 'test name')
       @work = Work.create!(title: 'test book', category: :album,
                        creator: 'test creator', publication: 2018,
                        description: 'test description')
     end

     it 'is valid when all fields are present' do
       vote = Vote.new(user_id: @user.id, work_id: @work.id)
       expect(vote.valid?).must_equal true
     end
   end
end
