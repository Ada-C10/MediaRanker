class CreateVotesIntermediary < ActiveRecord::Migration[5.2]
  def change
    create_table :votes_intermediaries do |t|
      add_column :votes, :status, :boolean
      add_reference :votes, :user, foreign_key: true
      add_reference :votes, :work, foreign_key: true
      t.string :table
    end
  end
end
