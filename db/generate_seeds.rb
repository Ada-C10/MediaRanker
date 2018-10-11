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
  :headers => ["category", "title", "creator", "publication_year", "description"]) do |csv|

    30.times do |i|
      category = %w(Album Book Movie).sample
      if category == "Book"
        title = Faker::HitchhikersGuideToTheGalaxy.starship + " " +  Faker::HitchhikersGuideToTheGalaxy.planet + " #{i}"
        creator = Faker::HitchhikersGuideToTheGalaxy.character
        publication_year = rand(Date.today.year-100..Date.today.year)
        description = Faker::HitchhikersGuideToTheGalaxy.quote
      end
      if category == "Album"
        title = Faker::Music.album + " in " + Faker::Music.key
        creator = Faker::Music.band
        publication_year = rand(Date.today.year-100..Date.today.year)
        description = (Faker::Music.genre + " " + Faker::Music.instrument)
      end
      if category == "Movie"
        title = Faker::StarWars.call_squadron + " " + Faker::StarWars.specie + " " +  Faker::StarWars.vehicle
        creator = Faker::StarWars.character
        publication_year = rand(Date.today.year-100..Date.today.year)
        description = Faker::Movie.quote
      end

      csv << [category, title, creator, publication_year, description]
    end
  end
