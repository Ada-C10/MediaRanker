class ChangeVoteModel < ActiveRecord::Migration[5.2]
  def change
    remove_column :votes, :username, :string
    remove_column :votes, :work, :string
    add_reference :votes, :user, foreign_key: true
    add_reference :votes, :work, foreign_key: true
  end
end
