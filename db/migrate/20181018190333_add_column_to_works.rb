class AddColumnToWorks < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :vote_count, :integer, default: 0
  end
end
