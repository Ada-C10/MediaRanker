class DeleteDateColumnVoteModel < ActiveRecord::Migration[5.2]
  def change
    remove_column :votes, :date_voted
  end
end
