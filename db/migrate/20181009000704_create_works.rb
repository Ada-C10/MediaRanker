class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :title
      t.string :description
      t.string :year_published
      t.string :created_by
      t.string :category

      t.timestamps
    end
  end
end
