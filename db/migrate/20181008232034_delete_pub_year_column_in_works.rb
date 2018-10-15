class DeletePubYearColumnInWorks < ActiveRecord::Migration[5.2]
  def change
    remove_column :works, :published_year, :string
  end
end
