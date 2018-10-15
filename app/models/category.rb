class Category < ApplicationRecord
  has_and_belongs_to_many :works
  #list all categories
  def self.show_all
    @categories = Category.all
  end
end
