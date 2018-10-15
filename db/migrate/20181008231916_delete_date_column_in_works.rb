class DeleteDateColumnInWorks < ActiveRecord::Migration[5.2]
  def change
    remove_column :works, :date, :string
  end
end
