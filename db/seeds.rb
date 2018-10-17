# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

WORKS_FILE = Rails.root.join('db', 'media_seeds.csv')
puts "Loading raw media data from #{WORKS_FILE}"

work_failures = []
CSV.foreach(WORKS_FILE, :headers => true) do |row|
  work = Work.new
  work.title = row['title']
  work.publication_year = row['publication_year']
  work.creator = row['creator']
  work.description = row['description']
  work.category = row['category']
  successful = work.save
  if !successful
    work_failures << work
    puts "Failed to save work: #{work.inspect}"
  else
    puts "Created works: #{work.inspect}"
  end
end

puts "Added #{Work.count} work records"
puts "#{work_failures.length} works failed to save"


# # Since we set the primary key (the ID) manually on each of the
# # tables, we've got to tell postgres to reload the latest ID
# # values. Otherwise when we create a new record it will try
# # to start at ID 1, which will be a conflict.
# puts "Manually resetting PK sequence on each table"
# ActiveRecord::Base.connection.tables.each do |t|
#   ActiveRecord::Base.connection.reset_pk_sequence!(t)
# end

puts "done"
