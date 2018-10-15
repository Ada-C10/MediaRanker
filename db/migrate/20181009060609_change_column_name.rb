class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :works, :year_published, :publication_year
  end
end
