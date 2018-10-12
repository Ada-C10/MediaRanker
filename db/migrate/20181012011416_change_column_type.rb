class ChangeColumnType < ActiveRecord::Migration[5.2]
  def change
    remove_column :votes, :user_id
    add_column :votes, :user_id, :integer
  end
end
