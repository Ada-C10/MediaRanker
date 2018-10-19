class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all.top(25)
    @movies = []
    @books = []
    @albums = []
    @works.each do |work|
      if work.category == "movie"
        @movies << work
      elsif work.category == "book"
        @books << work
      else
        @albums << work
      end
    end
  end

  def main
    @works = Work.all.top(25)
    @movies = []
    @books = []
    @albums = []
    @works.each do |work|
      if work.category == "movie"
        @movies << work
      elsif work.category == "book"
        @books << work
      else
        @albums << work
      end
    end
  end

  def show;  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = 'Work added!'
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = 'Work not added'
      render :new
    end
  end

  def edit; end

  def update
    if @work.update(work_params)
      flash[:success] = 'Work edited'
      redirect_to work_path(@work.id)
    else
      render :new
    end
  end

  def destroy
    if @work.votes.any?
      @work.votes.each do |vote|
        vote.destroy
      end
    end
    @work.destroy
    flash[:success] = 'Work is deleted'
    redirect_to works_path
  end

  private

  def find_work
    @work = Work.find_by(id: params[:id].to_i)

    if @work.nil?
      flash.now[:danger] = "Cannot find the work #{params[:id]}"
      render :not_found
    end
  end

  def work_params
    return params.require(:work).permit(:title, :publication_year, :creator, :description, :category)
  end
end
