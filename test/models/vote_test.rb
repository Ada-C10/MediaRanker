require "test_helper"

describe Vote do
  describe 'relations' do
    it 'has a user' do
      vote = votes(:one)
      vote.user.must_equal users(:one)
    end

    it 'can set the user' do
      vote = Vote.new(user: nil, work: nil)
      vote.user = users(:two)
      vote.user_id.must_equal users(:two).id
    end

    it 'has a work' do
      vote = votes(:three)
      vote.work.must_equal works(:nemo)
    end

    it 'can set the work' do
      vote = Vote.new(user: nil, work: nil)
      vote.work = works(:nemo)
      vote.work_id.must_equal works(:nemo).id
    end
  end

end
