class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.string :work_id
      t.string :user_id
      t.string :vote_time
      t.timestamps
    end
  end
end
