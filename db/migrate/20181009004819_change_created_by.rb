class ChangeCreatedBy < ActiveRecord::Migration[5.2]
  def change
    rename_column :works, :created_by, :creator
  end
end
