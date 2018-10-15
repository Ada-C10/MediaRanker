class UpdateForeignKey < ActiveRecord::Migration[5.2]
  def change
   # remove the old foreign_key
   remove_foreign_key :votes, :users
   remove_foreign_key :votes,
      :media

   # add the new foreign_key
   add_foreign_key :votes, :users, on_delete: :cascade
   add_foreign_key :votes, :media, on_delete: :cascade
 end
end
