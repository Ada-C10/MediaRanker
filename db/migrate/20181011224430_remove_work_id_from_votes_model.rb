class RemoveWorkIdFromVotesModel < ActiveRecord::Migration[5.2]
  def change
    remove_reference(:votes, :work, foreign_key: true)
  end
end
