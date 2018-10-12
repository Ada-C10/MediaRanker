class AddVoteCountColToWorksTable < ActiveRecord::Migration[5.2]
  def change
    # add a col to tally votes set default val to 0
    add_column :works, :votes_count, :integer, :default => 0

    # reset column info to prevent strange things
    Work.reset_column_information

  # update vote count values in db
    Work.all.each do |work|
      work.update_attribute :votes_count, work.votes.length
    end


  end
end
