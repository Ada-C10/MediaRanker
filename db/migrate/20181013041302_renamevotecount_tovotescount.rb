class RenamevotecountTovotescount < ActiveRecord::Migration[5.2]
  def change
    rename_column :works, :vote_count, :votes_count 
  end
end
