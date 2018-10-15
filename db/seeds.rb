# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'date'
require 'csv'

# we already provide a filled out media_seeds.csv file, but feel free to
# run this script in order to replace it and generate a new one
# run using the command:
# $ ruby db/generate_seeds.rb
# if satisfied with this new media_seeds.csv file, recreate the db with:
# $ rails db:reset
# doesn't currently check for if titles are unique against each other

WORK_FILE = Rails.root.join('db', 'media_seeds.csv')
puts "Loading raw work data from #{WORK_FILE}"

work_failures = []
CSV.foreach(WORK_FILE, :headers=> true) do |row|
    work = Work.new
    work.category = row["category"]
    work.title = row["title"]
    work.creator = row["creator"]
    work.publication_year = row['publication_year']
    work.description = row["description"]

    successful = work.save
    if !successful
      work_failures << work
      puts "Failed to save work: #{work.inspect}"
    else
      puts "Added a work: #{work.inspect}"
    end
end

puts "Added #{Work.count} work records"
puts "#{work_failures.length} works failed to save"
  # work.publication_year = Date.parse("#{row['publication_year']}-1-1")
