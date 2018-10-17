class RenameColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :works, :published_year, :publication_year
  end
end
