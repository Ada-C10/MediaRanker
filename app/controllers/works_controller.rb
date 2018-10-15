class WorksController < ApplicationController

  def index
    @books = Work.list_by_votes("book")
    @albums = Work.list_by_votes("album")
    @movies = Work.list_by_votes("movie")

  end

  def show
    id = params[:id]
    @work = Work.find_by(id: id)

    if id == nil
      render :not_found, status: :not_found
    end

  end

  def main
    @works = Work.spotlight
    @books = Work.list_by_votes("book")
    @albums = Work.list_by_votes("album")
    @movies = Work.list_by_votes("movie")

    @top_work = Work.spotlight.first
  end

  def edit
    id = params[:id]
    @work = Work.find_by(id: id)
  end

  def new
    @work = Work.new
    if params[:user_id]
      @user_id =  params[:user_id]
      @work.user_id = @user_id
    end

  end

  def update
    if @work && @work.update(work_params) #(if user exists AND can be updated)
       # @work.user_id = session[:user_id]
       flash[:success] = "#{@work.title} has been edited."
       redirect_to work_path(@work.id)
     else
       flash.now[:warning] = 'Sorry, no edits were saved.'
       render :edit
     end


    # id = params[:id]
    # @work = Work.find_by(id: id)
    # @work.update(work_params)
    #
    # if @work.save
    #   redirect_to work_path # go to the index so we can see the book in the list
    # else
    #   render :new
    # end
  end


  def create
    @work = Work.new(work_params)

    if @current_user.nil?
      flash[:danger] = "You must be logged in to create a new work"
      render :new
    elsif
      if @work.save
        flash[:success] = "#{@work.title} has been created"
        redirect_to work_path(@work.id)
      else # save failed :(
        flash.now[:warning] = 'Work not created'
        render :new
      end
    end
  end

  def upvote
    id = params[:id]
    @work = Work.find_by(id: id)

    if @current_user
      @work.upvote(user_id: @current_user.id)
      if @work.save
        flash[:success] = "Your vote was added"
        redirect_to works_path
      else
        flash[:warning] = "Your can only vote once for this work"
        redirect_to works_path
      end
    elsif @current_user.nil?
      flash[:warning] = "You must be logged in to vote"
      redirect_to works_path
    end
  end


  def destroy
    id = params[:id]
    @work = Work.find_by(id: id)
    if @work.destroy
      flash[:success] = "#{@work.title} deleted"
      redirect_to root_path
    end
  end

  private
  def work_params
    return params.require(:work).permit(:title, :category, :publication_year, :creator, :description, :user_id)
  end

end
