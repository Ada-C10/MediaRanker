module PagesHelper

  def all_books
    books = Work.where(category: "Book")
  end

  def all_movies
    movies = Work.where(category: "Movie")
  end

  def all_albums
    albums = Work.where(category: "Album")
  end

end
