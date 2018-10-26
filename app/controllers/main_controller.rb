class MainController < ApplicationController
  def index
    @albums = Work.albums.order(votes_count: :desc).limit(10)
    @movies = Work.movies.order(votes_count: :desc).limit(10)
    @books = Work.books.order(votes_count: :desc).limit(10)
    @spotlight = Work.order(votes_count: :desc).first
  end
end
