class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :title
      t.integer :publication_year
      t.string :description
      t.string :creator
      t.string :category

      t.timestamps
    end
  end
end
