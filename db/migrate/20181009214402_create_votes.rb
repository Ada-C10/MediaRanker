class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.datetime :voted_on
      t.integer :votes

      t.timestamps
    end
  end
end
