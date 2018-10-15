class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.string :username
      t.string :work

      t.timestamps
    end
  end
end
