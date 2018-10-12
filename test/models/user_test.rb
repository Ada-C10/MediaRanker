require "test_helper"

describe User do
  let(:user) { User.new }

  # it "must be valid" do
  #   value(user).must_be :valid?
  # end

  it 'has required fields' do
    fields = [:user_name ]

    fields.each do |field|
      expect(user).must_respond_to field
    end
  end
end

# describe 'user_list' do
#   it 'should return an array' do
#
#     users = User.user_list
#
#     expect(users).must_be_instance_of Array
#
#     users.each do |user_array|
#       current_user = User.find(user_array[1])
#       user_name = user_array[0]
#       expect(user_name).must_equal current_user.name
#     end
#   end
# end
