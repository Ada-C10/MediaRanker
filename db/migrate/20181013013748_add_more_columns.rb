class AddMoreColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :category, :string
    add_column :works, :title, :string
    add_column :works, :publication_year, :string
    add_column :works, :creator, :string
  end
end
