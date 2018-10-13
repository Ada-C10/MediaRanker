class ChangeColumnNames < ActiveRecord::Migration[5.2]
  def change
    rename_table :user, :users
    rename_table :vote, :votes
  end
end
