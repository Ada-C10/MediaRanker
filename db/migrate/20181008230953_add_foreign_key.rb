class AddForeignKey < ActiveRecord::Migration[5.2]
  def change
    add_reference :votes, :user, foreign_key: true
  end
end
