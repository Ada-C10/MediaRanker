class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :title
      t.string :creator
      t.integer :published
      t.string :description
      t.string :category

      t.timestamps
    end

    create_table :user do |t|
      t.string :username

      t.timestamps
    end

    create_table :vote do |t|
      t.belongs_to :user, index: true
      t.belongs_to :work, index: true

      t.timestamps
    end
  end
end
