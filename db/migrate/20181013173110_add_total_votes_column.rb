class AddTotalVotesColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :total_votes, :integer, default: 0
  end
end
