class Category < ApplicationRecord
  has_and_belongs_to_many :works

  def category_names
    Category.count
  end
end
