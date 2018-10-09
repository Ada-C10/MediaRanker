class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.date :date_created

      t.timestamps
    end
  end
end
