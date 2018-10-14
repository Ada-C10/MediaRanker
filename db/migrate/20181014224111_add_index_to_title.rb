class AddIndexToTitle < ActiveRecord::Migration[5.2]
  def change
    add_index :works, :title, unique:  true
  end
end
