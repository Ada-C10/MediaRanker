class AddColumnsToWorks < ActiveRecord::Migration[5.2]
  def change
    add_column(:works, :title, :string)
    add_column(:works, :year, :date)
    add_column(:works, :creator, :string)
    add_column(:works, :category, :string)
    add_column(:works, :description, :string)

  end
end
