class AddCategoryAndPublicationyearToWorks < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :category, :string
    add_column :works, :publication_year, :integer 
  end
end
