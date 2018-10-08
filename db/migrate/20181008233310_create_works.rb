class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :title
      t.integer :published_year
      t.string :category
      t.string :creator
      t.string :description

      t.timestamps
    end
  end
end
