class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :votes, :topic_id, :category
  end
end
