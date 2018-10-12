class WorksController < ApplicationController

  def index
    @works = Work.all
  end


  def show
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
    end
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
      flash.now[:error] = "did not save"
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
    ##search for the user via session id - error if logged out user

    session[:user_id] = user.id
    user = User.find(session[:user_id])

    ##search for work via param
    @work = Work.find_by(id: params[:id])

    ##Vote.new(user id, work id)
    @vote = @work.votes.new(user: @user, work: @work)

    ##if success, flash "Successfully upvoted!" and stay on page
    if @vote.save
      flash[:success] = "Successfully upvoted!"
      render :new

    ##else "you can only upvote a piece of media one time"
    else
      flash[:error] = "an error has occurred with either the user #{@user} or work #{@work}"
      render 'works/show/'
    end

  end


  private
  def work_params
    return params.require(:work).permit(:category, :title, :publication_year, :description, :creator)
  end
end
