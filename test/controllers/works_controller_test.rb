require "test_helper"

describe WorksController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  it "should get index" do
    get works_path
    must_respond_with :success
  end

  it "should respond with success for showing an existing work" do
    existing_work = works(:work_1)
    get work_path(existing_work.id)
    must_respond_with :success
  end

  it "should respond with not found for showing a non existant work" do

    #arrange. have to destroy a fixture work or else will throw error
    work = works(:work_1)
    id = work.id
    work.destroy

    #act
    get work_path(id)

    #Assert
    must_respond_with :not_found
  end

end
