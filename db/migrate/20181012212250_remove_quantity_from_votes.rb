class RemoveQuantityFromVotes < ActiveRecord::Migration[5.2]
  def change
    remove_column :votes, :quantity
  end
end
