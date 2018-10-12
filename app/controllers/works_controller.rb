require 'pry'
class WorksController < ApplicationController

  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def home
    #filter by movies, books, and albums--then call .soryby!

    @albums = Work.where(category: "album")
    @albums = (@albums.sort_by { |album| album.total_votes()}).reverse!

    # users.sort_by { |user| [user.age, user.name] }

  end


  def upvote
    work = Work.find_by(id: params[:id])

    if session[:user_id] == nil
      flash[:error] = "You must be logged in"
    elsif session[:user_id]
      user = User.find(session[:user_id])
      already_voted = Vote.find_by(work_id: work.id, user_id: user.id)
      if already_voted
        flash[:error] = "You can't vote for the same source again"
      elsif
        vote = Vote.new(work_id: work.id, user_id: user.id)
        is_successful_save = vote.save
        if is_successful_save
          flash[:success] = "Successfully Voted"
        else
          render status: :bad_request
        end

      end
    end
    redirect_to root_path
  end

  def index


    @albums = Work.where(category: "album")
    @albums = (@albums.sort_by { |album| album.total_votes()}).reverse!


    @books = Work.where(category: "book")
    @books = (@books.sort_by { |book| book.total_votes()}).reverse!

    #
    # @works = Work.all.to_a
    # @works = (@works.sort_by { |work| work.total_votes()}).reverse!
  end

  def show
    # @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
    end
  end

  def new
    @work = Work.new
  end

  def create
    filtered_work_params = work_params()
    @work = Work.new(filtered_work_params)

    is_successful_save = @work.save

    if is_successful_save
      redirect_to works_path
    else
      render :new, status: :bad_request
    end

  end

  def edit
    # @work = Work.find_by(id: params[:id])
  end

  def update
    # work = Work.find(params[:id])
    if @work.update(work_params)
      redirect_to work_path(@work.id)
    else
      render :edit, status: :bad_request
    end
  end


  def destroy
    # work = Work.find_by(id: params[:id])
    @work.destroy
    redirect_to works_path
  end



  private

  def work_params
    return params.require(:work).permit(
      :title,
      :category,
      :creator,
      :publication_year,
      :description,
    )
  end


  def find_work
    @work = Work.find_by(id: params[:id])
  end


end
