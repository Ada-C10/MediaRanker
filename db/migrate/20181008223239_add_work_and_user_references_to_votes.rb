class AddWorkAndUserReferencesToVotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :votes, :work, foreign_key: true, on_delete: :cascade
    add_reference :votes, :user, foreign_key: true, on_delete: :cascade
  end
end
