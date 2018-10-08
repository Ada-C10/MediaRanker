class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :title
      t.string :category
      t.string :creator
      t.date :pub_date
      t.string :description

      t.timestamps
    end
  end
end
