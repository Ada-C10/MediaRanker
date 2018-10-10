class PagesController < ApplicationController
  def show
    if params[:page] == "home"
      @movies = Medium.where(category: "movie")
      @books = Medium.where(category: "book")
      @albums = Medium.where(category: "album")
      
      @media_spotlight = Medium.spotlight
    end

    render template: "pages/#{params[:page]}"
  end
end
