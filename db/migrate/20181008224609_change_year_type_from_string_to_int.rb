class ChangeYearTypeFromStringToInt < ActiveRecord::Migration[5.2]
  def change
    remove_column :works, :pub_year, :string
    add_column :works, :pub_year, :int
  end
end
