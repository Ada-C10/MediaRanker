class MediarankerController < ApplicationController
  def main
    @works = Work.all
    @movies = (Work.where(category: "movie")).ordering.limit(10)
    @books = (Work.where(category: "book")).ordering.limit(10)
    @albums = (Work.where(category: "album")).ordering.limit(10)
  end
end
