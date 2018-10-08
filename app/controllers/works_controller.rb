class WorksController < ApplicationController
  before_action :get_work, only: [:show, :edit]
  def get_work
    @work = Work.find(params[:id].to_i)
  end

  def index
    @books = Work.all.where(category: "book")
    @movies = Work.all.where(category: "movie")
    @albums = Work.all.where(category: "album")
  end

  def show
  end

  def new
    @work = Work.new
  end

  def edit
  end

  def update
  end

  def create
  end

  def destroy
  end
end
