# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Work.create(category: "Book", title: "September", creator: "Bob", published_year: "01-01-2015", description: "great book")
Work.create(category: "Album", title: "June", creator: "Sue", published_year: "07-01-2015", description: "good music")
Work.create(category: "Album", title: "May", creator: "Sam", published_year: "01-01-2015", description: "good music")
Work.create(category: "Movie", title: "August", creator: "John", published_year: "01-01-2016", description: "good movie")
