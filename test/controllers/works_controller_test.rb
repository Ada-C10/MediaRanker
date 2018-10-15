require "test_helper"

describe WorksController do
  it "should respond with not found for showing a non-existant book" do
    #ARRANGE
    work = works(:work6)
    id = work.id

    get work_path(id)
    must_respond_with :success

    work.destroy

    #ACT
    get work_path(id)

    #ASSERT
    must_respond_with :missing
  end
end
