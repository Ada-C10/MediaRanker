class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def home

  end

  def index
    @albums = Work.album_list
    @books = Work.book_list
    @movies = Work.movie_list
  end

  def show; end


  def new
    @work = Work.new
  end

  def edit; end


  def destroy

    if !@work.nil?
      if @work.votes.nil? || @work.votes.count < 1
        @work.destroy
        flash[:success] = "#{@work.title} deleted"
        redirect_to root_path
      else
        flash[:warning] = "#{@work.title} cannot be deleted, there are votes on it!"
        redirect_back fallback_location: works_path
      end
    end
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "Successfully created #{@work.category} #{@work.title}!"

      redirect_to work_path(id: @work.id)
    else
      flash.now[:warning] = "Item is not created!"
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end

      render :new
    end
  end

  def update

    if @work && @work.update(work_params)
      flash[:success] = "Successfully edited!"
      redirect_to work_path(@work.id)
    elsif @work
      flash.now[:warning] = "Item is not updated!"
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :edit
    end
  end

  def upvote

    if !session[:user_id]
      flash[:warning] = "A problem occurred: You must log in to do that"

    else

      work = Work.find_by(id: params[:id].to_i)

      if Vote.duplicated_votes( @current_user.id, work.id) == false
         vote = Vote.new
         vote.user_id = @current_user.id
         vote.work_id = work.id

         if vote.save
           flash[:success] = "Successfully upvoted!"

         else
           flash[:warning] = "Cannot save, try again!"

        end
      else
        flash[:warning]= "Already upvoted!"
     end
   end
   redirect_back fallback_location: works_path
  end


private

  def find_work
    @work = Work.find_by(id: params[:id].to_i)

    if @work.nil?
      flash[:warning] = "Cannot find #{@work.title}"
      redirect_to works_path
    end
  end

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end


end
