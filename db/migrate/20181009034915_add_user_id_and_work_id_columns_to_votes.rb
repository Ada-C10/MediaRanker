class AddUserIdAndWorkIdColumnsToVotes < ActiveRecord::Migration[5.2]
  def change
    add_column :votes, :work_id, :integer
    add_column :votes, :user_id, :integer
  end
end
