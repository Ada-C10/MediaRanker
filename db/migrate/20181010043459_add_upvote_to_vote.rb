class AddUpvoteToVote < ActiveRecord::Migration[5.2]
  def change
    add_column :votes, :upvote, :integer
  end
end
