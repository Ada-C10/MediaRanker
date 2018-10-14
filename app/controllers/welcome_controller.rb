class WelcomeController < ApplicationController

  before_action :find_top_ten_movies, only: :index
  before_action :find_top_ten_books, only: :index
  before_action :find_top_ten_albums, only: :index
  before_action :find_spotlight_work, only: :index

  def index
  end

  private

  def find_spotlight_work
  @spotlight_work = Work.left_joins(:votes).group(:id).order('COUNT(votes.id) DESC').limit(1)
  end

  def find_top_ten_movies
      @top_ten_movies = Work.where(category: 'movie').left_joins(:votes).group(:title).order('COUNT(votes.id) DESC').limit(10)
  end

  def find_top_ten_books
    @top_ten_books = Work.where(category: 'book').left_joins(:votes).group(:id).order('COUNT(votes.id) DESC').limit(10)
  end

  def find_top_ten_albums
      @top_ten_albums = Work.where(category: 'album').left_joins(:votes).group(:id).order('COUNT(votes.id) DESC').limit(10)
  end
end
