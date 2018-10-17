FactoryBot.define do
  factory :work do
    title { Faker::Music.unique.album }
    creator { Faker::RuPaul.queen }
    description { Faker::RuPaul.quote }
    category { "movie" }
    publication_year { Faker::Number.between(1888, 2018) }
    votes_count { Faker::Number.between(0, 15) }
  end
end

