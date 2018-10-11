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

    75.times do
      category = %w(album book movie).sample
      if category == "book"
        title = Faker::HitchhikersGuideToTheGalaxy.starship + Faker::HitchhikersGuideToTheGalaxy.planet
        creator = Faker::HitchhikersGuideToTheGalaxy.character
        publication_year = rand(Date.today.year-100..Date.today.year)
        description = Faker::HitchhikersGuideToTheGalaxy.quote
      end
      if category == "album"
        title = Faker::Music.album
        creator = Faker::Music.band
        publication_year = rand(Date.today.year-100..Date.today.year)
        description = (Faker::Music.genre + " " + Faker::Music.instrument)
      end
      if category == "movie"
        title = Faker::StarWars.call_squadron + " " + Faker::StarWars.specie + " " +  Faker::StarWars.vehicle
        creator = Faker::StarWars.character
        publication_year = rand(Date.today.year-100..Date.today.year)
        description = Faker::Movie.quote
      end

      csv << [category, title, creator, publication_year, description]
    end
  end
