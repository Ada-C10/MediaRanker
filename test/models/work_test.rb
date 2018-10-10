require "test_helper"

describe Work do



describe 'validations' do
  #everything is good and valid (do this for each model)
  #make a new work with valid (present & unique) title
  #calling .valid? on it will be true

  it 'is valid when title is present and unique' do

    #arrange
    work = Work.new(title: 'test')

    #act
    is_valid = work.valid?

    #assert
    expect( is_valid ).must_equal true
  end

end


#works must have a method that is part of the relationship to votes
#must have a .votes method

#work that doesn't have a title is not valid
#work with nil title or not provided will
#when calling .valid? will return false

#a work that has a non-unique title is not valid
#there is an instance of work a
#there is an instance of work b with the same title
#calling .valid? on second book will return false




end
