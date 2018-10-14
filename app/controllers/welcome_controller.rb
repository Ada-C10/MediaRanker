class WelcomeController < ApplicationController

  before_action :find_all_works, only: :index
  before_action :find_top_ten_movies, only: :index
  before_action :find_top_ten_books, only: :index
  before_action :find_top_ten_albums, only: :index
  before_action :find_spotlight_work, only: :index

  def index
  end

  private

  def find_votes
    @works ||= Work.all
  end

  def find_spotlight_work
  end

  def find_top_ten_movies
  end

  def find_top_ten_books
  end

  def find_top_ten_albums
  end


end
