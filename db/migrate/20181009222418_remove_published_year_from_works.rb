class RemovePublishedYearFromWorks < ActiveRecord::Migration[5.2]
  def change
    remove_column :works, :published_year
  end
end
