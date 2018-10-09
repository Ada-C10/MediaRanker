require "test_helper"


# create_table "works", force: :cascade do |t|
#   t.string "title"
#   t.string "category"
#   t.string "creator"
#   t.integer "publication_year"
#   t.string "description"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end


describe Work do

  describe 'relations' do
    work = Work.create!(title: 'album')

    # let(:work) { Work.new }
    #
    # it "must be valid" do
    #   value(work).must_be :valid?
    # end

    it "must be valid when all fields are present" do
      value(work).must_be :valid?
    end

  end


end
