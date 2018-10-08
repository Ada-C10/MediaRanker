class ChangeDataType < ActiveRecord::Migration[5.2]
  def change
    change_column(:works, :publication_year, :datetime)
  end
end
