require 'csv'
require 'faker'
require 'date'

WORK_FILE = Rails.root.join('db', 'media_seeds.csv')
puts "Loading raw driver data from #{WORK_FILE}"

work_failures = []
CSV.foreach(WORK_FILE, :headers => true) do |row|
  work = Work.new
  work.category = row['category']
  work.title = row['title']
  work.creator = row['creator']
  work.publication_year = row['publication_year']
  work.description = row['description']
  successful = work.save
  if !successful
    work_failures << work
    puts "Failed to save work: #{work.inspect}" # so user can check that work to see what happened
  else
    puts "Created work: #{work.inspect}"
  end
end

puts "Added #{Work.count} work records"
puts "#{work_failures.length} works failed to save"

user_failures = []
10.times do
  creator = Faker::Name.name
  user = User.new
  user.name = creator
  successful = user.save
  if !successful
    user_failures << user
    puts "Failed to save user: #{user.inspect}" # so user can check that work to see what happened
  else
    puts "Created user: #{user.inspect}"
  end
end

puts "Added #{User.count} user records"
puts "#{user_failures.length} users failed to save"


puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "done"
