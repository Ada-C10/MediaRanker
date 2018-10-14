class PagesController < ApplicationController
  
  def home
    @movies = Medium.where(category: "movie")
    @books = Medium.where(category: "book")
    @albums = Medium.where(category: "album")

    @media_spotlight = Medium.spotlight
  end

end
