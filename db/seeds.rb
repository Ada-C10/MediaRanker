require 'csv'

MEDIA_FILE = Rails.root.join('db', 'media_seeds.csv')
puts "Loading raw trip data from #{MEDIA_FILE}"

media_failures = []
CSV.foreach(MEDIA_FILE, :headers => true) do |row|
  media = Work.new
  media.category = row['category']
  media.title = row['title']
  media.creator = row['creator']
  media.publication_year = row['publication_year']
  media.description = row['description']

  successful = media.save
  if !successful
    media_failures << media
    puts "Failed to save media: #{media.inspect}"
  else
    puts "Created media: #{media.inspect}"
  end
end

puts "Added #{Work.count} media records"
puts "#{media_failures.length} medium failed to save"
puts "done"
