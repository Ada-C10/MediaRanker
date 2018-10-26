class RemoveJoinDateAndVotes < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :joined_date, :string
    remove_column :users, :votes, :string
  end
end
