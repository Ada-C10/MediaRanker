class AddVotesReferenceToWorksModel < ActiveRecord::Migration[5.2]
  def change
    add_reference(:works, :votes, index: true, foreign_key: true)
  end
end
