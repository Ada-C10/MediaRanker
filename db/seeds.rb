require 'csv'

MEDIA_SEEDS_FILE = Rails.root.join('db', 'media_seeds.csv')
puts "Loading raw media data from #{MEDIA_SEEDS_FILE }"

media_failures = []
CSV.foreach(MEDIA_SEEDS_FILE, :headers => true) do |row|
  work = Work.new
  work.id = row['id']
  work.title = row['title']
  work.category = row['category']
  work.creator = row['creator']
  work.publication_year = row['publication_year']
  work.description = row['description']
  successful = work.save
  if !successful
    media_failures << work
    puts "Failed to save work: #{work.inspect}"
  else
    puts "Created work: #{work.inspect}"
  end
end

puts "Added #{Work.count} work records"
puts "#{media_failures.length} work failed to save"
