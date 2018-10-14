class WorksController < ApplicationController

  def index
    @albums = Work.albums
    @books = Work.books
    @movies = Work.movies
  end

  def home
    @albums_home = Work.albums[0...10]
    @books_home = Work.books[0...10]
    @movies_home = Work.movies[0...10]

    @top_work = Work.all.sort_by{ |work| work.votes.length}.last
  end


  def show
    id = params[:id].to_i
    @work = Work.find_by(id: id)
  end

  def edit
    @work = Work.find(params[:id].to_i)
  end

  def update
    @work = Work.find_by(id: params[:id].to_i)
    if @work.update(work_params)
      flash[:success] = 'Media Edited!'
      redirect_to work_path(@work.id)
    else
      flash.now[:danger] = 'ERROR!'
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :edit
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = 'Media Added!'
      redirect_to work_path(@work.id)
    else
      flash.now[:danger] = 'ERROR!'
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end

      render :new
    end
  end

  def destroy
    work = Work.find_by(id: params[:id].to_i)
    @work = work.destroy
    redirect_to works_path
  end

  def upvote

    if @current_user
      work = Work.find_by(id: params[:id].to_i)
      user = User.find_by(id: session[:user_id])
      @vote = Vote.create(work: work, user: user)

      if @vote.valid?
        flash[:success] = "Upvoted!"
      else
        flash[:danger] = "You can only upvote one time! Error!"
        redirect_back fallback_location: root_path
      end
    else
      flash[:danger] = "You must log in."

      redirect_back fallback_location: root_path
    end
  end




  private

  def work_params
    return params.require(:work).permit(:title, :creator, :publication_year, :description, :category)
  end
end
