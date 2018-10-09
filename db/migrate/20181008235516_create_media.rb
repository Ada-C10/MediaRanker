class CreateMedia < ActiveRecord::Migration[5.2]
  def change
    create_table :media do |t|
      t.string :title
      t.string :description
      t.string :ccategory
      t.string :creator
      t.integer :publication_year

      t.timestamps
    end
  end
end
