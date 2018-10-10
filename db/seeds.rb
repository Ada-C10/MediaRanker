require 'csv'

CSV.foreach(Rails.root.join('db', 'media_seeds.csv'), headers: true) do |row|
  w = Work.new
  w.category = row['category']
  w.title = row['title']
  w.creator = row['creator']
  w.pub_year = row['pub_year']
  w.description = row['description']
  w.save
  puts "#{w.title} by #{w.creator} saved"
end

puts "There are now #{Work.count} rows in the works table"
