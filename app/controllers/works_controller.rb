class WorksController < ApplicationController

  def index
    @works = Work.all

    @all_books = Work.ranked_media("Book")
    @all_movies = Work.ranked_media("Movie")
    @all_albums = Work.ranked_media("Album")
  end


  def show
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
    end

    @voters = @work.see_voters
  end


  def new
    @work = Work.new
  end


  def create
    @work = Work.new(work_params)

    is_successful_save = @work.save

    if is_successful_save
      flash[:success] = "Successfully added new media: #{@work.title}"
      redirect_to work_path(@work)
    else
      render :new, status: :bad_request
    end
  end


  def edit
    @work = Work.find_by(id: params[:id])
  end


  def update
    @work = Work.find_by(id: params[:id])

    if @work.update(work_params)
      flash[:success] = "work #{@work.title} has been successfully updated."
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "could not be updated"
      render :edit, status: :bad_request
    end
  end


  def destroy
    @work = Work.find_by(id: params[:id])
    @work.destroy

    flash[:success] = "successfully deleted work \"#{@work.title}\""
    redirect_to works_path
  end


  def upvote

    if session[:user_id]

      @user = User.find(session[:user_id])

      @work = Work.find_by(id: params[:id])

      @vote = @work.votes.new(user: @user)

      if @vote.save
        flash[:success] = "Successfully upvoted!"

        redirect_to work_path(@work)

      else
        flash.now[:error] = "An error has occurred. Please try again."
        render :show
      end

    else
      flash.now[:error] = "You must be logged in to cast a vote."
      @work = Work.find_by(id: params[:id])
      @voters = @work.see_voters

      render :show

    end
  end


  private
  def work_params
    return params.require(:work).permit(:category, :title, :publication_year, :description, :creator)
  end
end
