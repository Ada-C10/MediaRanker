class DeleteAccidentalColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :votes, :user_id, :integer
    remove_column :votes, :work_id, :integer
  end
end
