class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :title
      t.string :catergory
      t.string :created_by
      t.datetime :Published
      t.integer :Votes

      t.timestamps
    end
  end
end
