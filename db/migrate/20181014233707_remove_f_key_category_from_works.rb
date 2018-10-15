class RemoveFKeyCategoryFromWorks < ActiveRecord::Migration[5.2]
  def change
    remove_reference :works, :category, foreign_key: true
  end
end
