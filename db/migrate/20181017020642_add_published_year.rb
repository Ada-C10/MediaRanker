class AddPublishedYear < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :publication_year, :string
    add_column :works, :description, :string

  end
end
