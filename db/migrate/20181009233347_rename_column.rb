class RenameColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :works, :creater, :creator
  end
end
