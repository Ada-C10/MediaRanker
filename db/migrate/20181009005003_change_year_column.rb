class ChangeYearColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :works, :pub_year
    add_column :works, :publication_year, :integer
  end
end
