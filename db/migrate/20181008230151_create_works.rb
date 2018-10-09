class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :title
      t.string :string
      t.string :published_year
      t.string :date
      t.string :creator
      t.string :string
      t.string :description
      t.string :string
      t.string :category
      t.string :string

      t.timestamps
    end
  end
end
