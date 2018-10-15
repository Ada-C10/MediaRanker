class RemoveReference < ActiveRecord::Migration[5.2]
  def change
    remove_reference(:works, :vote, foreign_key: true)
  end
end
