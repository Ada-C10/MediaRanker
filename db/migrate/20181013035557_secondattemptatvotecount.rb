class Secondattemptatvotecount < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :vote_count, :integer, default: 0
    Work.reset_column_information
    Work.all.each do |c|
      Work.update_counters c.id, vote_count: c.votes.length
    end
  end
end
