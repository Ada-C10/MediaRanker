class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :works, :pub_year, :publication_year
  end
end
