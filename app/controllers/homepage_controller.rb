class HomepageController < ApplicationController
  def index
    # @movies = Work.where(category: "movie")
    @movies = Work.where(category: "movie").order(total_votes: :desc).take(10)
    # @books = Work.where(category: "book")
    @books = Work.where(category: "book").order(total_votes: :desc).take(10)

    @albums = Work.where(category: "album").order(total_votes: :desc).take(10)
    # @albums = Work.where(category: "album")
  end
end
