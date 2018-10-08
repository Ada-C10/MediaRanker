require 'csv'

MEDIA_SEEDS = Rails.root.join('db', 'media_seeds.csv')

media_failures = []
CSV.foreach(MEDIA_SEEDS, :headers => true) do |row|
  work = Work.new
  work.category = row['category']
  work.title = row['title']
  work.creator = row['creator']
  work.pub_year = row['publication_year']
  work.description = row['description']

  successful = work.save
  if !successful
    media_failures << work
    puts "Failed to save media: #{work.inspect}"
  end
end

puts "Added #{Work.count} works"
puts "#{media_failures.length} works failed to save"
