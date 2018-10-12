class AddUserVotesIdToVotes < ActiveRecord::Migration[5.2]
  def change
    add_column :votes, :user_id, :string
    add_column :votes, :votes_id, :string
  end
end
