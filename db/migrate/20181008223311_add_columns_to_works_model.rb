class AddColumnsToWorksModel < ActiveRecord::Migration[5.2]
  def change
    add_reference :works, :user, foreign_key: true
    add_reference :works, :vote, foreign_key: true
  end
end
