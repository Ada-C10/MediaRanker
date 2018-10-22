class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    remove_column :votes, :votes_id
    add_column :votes, :work_id, :integer
  end

end
