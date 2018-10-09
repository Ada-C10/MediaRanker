require "test_helper"

require 'pry'
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

    before do
      @work = works(:blue)
    end

    it "must be valid when all fields are present" do
      @work.title.must_equal "Blue Breaker"
      is_valid = @work.valid?
      expect( is_valid ).must_equal true
    end


    it "must not be valid for duplicate title with the same category" do
      work1 = Work.new(title: @work.title, category: @work.category)
      # binding.pry
      is_valid = work1.valid?
      expect( is_valid ).must_equal false
    end


    it "must be valid for same title but different category" do
      work1 = Work.new(title: @work.title, category: "movie")

      is_valid = work1.valid?
      expect( is_valid ).must_equal true

    end




  end


end
