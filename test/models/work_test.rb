require "test_helper"

describe Work do
  let(:work) { works(:kings) }

  describe "Relationships" do
    it "can have many votes" do
      expect(work.votes.count).must_equal 2
    end

    it "can have 0 votes" do
      work = Work.new(title: "Aladdin")
      expect(work.votes.count).must_equal 0
    end

    it "can access users through votes" do
      expect(work.users.length).must_be :>=, 0

      work.users.each do |user|
        expect(user).must_be_instance_of User
      end
    end
  end

  describe "Validations" do
    it "is valid when all fields are present" do
      expect(work).must_be :valid?
    end

    it "must have a title" do
      work.title = nil

      valid = work.valid?

      expect(valid).must_equal false
      expect(work.errors.messages).must_include :title
    end

    it "must have a unique title for the same category" do
      other_work = Work.new title: work.title, category: "book"
      other_work.save

      valid = other_work.valid?

      expect(valid).must_equal false
      expect(other_work.errors.messages).must_include :title
    end

    it "can have the same title for different categories" do
      other_work = Work.new title: work.title, category: "album"
      other_work.save

      valid = other_work.valid?

      expect(valid).must_equal true
    end
  end

  describe "Custom Methods" do
    
  end
end
