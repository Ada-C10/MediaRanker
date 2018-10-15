class AddUserAndWorkReferencesToVote < ActiveRecord::Migration[5.2]
  def change
  add_reference :votes, :work, foreign_key: true
  remove_reference :works, :votes, index: true, foreign_key: true
  end
end
