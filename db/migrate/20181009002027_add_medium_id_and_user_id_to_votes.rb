class AddMediumIdAndUserIdToVotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :votes, :user, foreign_key: true
    add_reference :votes, :medium, foreign_key: true
  end
end
