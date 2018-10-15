class DeleteStringColInWorks < ActiveRecord::Migration[5.2]
  def change
    remove_column :works, :string, :string
  end
end
