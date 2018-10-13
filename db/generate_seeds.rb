require 'faker'
require 'date'
require 'csv'

# we already provide a filled out media_seeds.csv file, but feel free to
# run this script in order to replace it and generate a new one
# run using the command:
# $ ruby db/generate_seeds.rb
# if satisfied with this new media_seeds.csv file, recreate the db with:
# $ rails db:reset
# doesn't currently check for if titles are unique against each other

CSV.open('db/media_seeds.csv', "w", :write_headers=> true,
  :headers => ["category", "title", "creator", "published", "description"]) do |csv|

  25.times do
    category = %w(album book movie).sample
    title = Faker::Coffee.blend_name
    creator = Faker::Name.name
    published = rand(1700..2018)
    description = Faker::Lorem.sentence

    csv << [category, title, creator, published, description]
  end
end
