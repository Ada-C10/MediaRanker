class RemoveVotedOnandVotes < ActiveRecord::Migration[5.2]
  def change
    remove_column :votes, :voted_on, :string
    remove_column :votes, :votes, :string
  end
end
