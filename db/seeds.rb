# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

MEDIA_FILE = Rails.root.join('db', 'media_seeds.csv')
puts "Loading raw driver data from #{MEDIA_FILE}"

media_failures = []
CSV.foreach(MEDIA_FILE, :headers => true) do |row|
  medium = Medium.new
  medium.category = row['category']
  medium.title = row['title']
  medium.creator = row['creator']
  medium.publication_year = row['publication_year']
  medium.description = row['description']
  successful = medium.save
  if !successful
    media_failures << medium
    puts "Failed to save medium: #{medium.inspect}"
  else
    puts "Created medium: #{medium.inspect}"
  end
end

puts "Added #{Medium.count} medium records"
puts "#{media_failures.length} media failed to save"
