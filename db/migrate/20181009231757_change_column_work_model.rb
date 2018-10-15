class ChangeColumnWorkModel < ActiveRecord::Migration[5.2]
  def change
    rename_column :works, :caategory, :category
  end
end
