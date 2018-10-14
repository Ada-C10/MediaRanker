class AddVotesCountToWork < ActiveRecord::Migration[5.2]
  def up
    add_column :works, :votes_count, :integer, default: 0
    Work.reset_column_information
    Work.all.each do |w|
      Work.update_counters w.id, votes_count: w.votes.length
    end
  end
  def down
    remove_column :work, :votes_count
  end
end
