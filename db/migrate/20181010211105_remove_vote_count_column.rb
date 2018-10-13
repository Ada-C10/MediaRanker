class RemoveVoteCountColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :works, :vote_count
  end
end
