class CreateCategoriesWorksJoin < ActiveRecord::Migration[5.2]
  def change
    create_table :categories_works do |t|
      t.belongs_to :work, index: true
      t.belongs_to :category, index: true
    end
  end
end
