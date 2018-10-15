class ChangeNameOfCategory < ActiveRecord::Migration[5.2]
  def change
    rename_column :categories, :type, :name
  end
end
