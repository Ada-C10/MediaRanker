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
    @works = Work.all
    @books = Work.list_by_votes("book")
    @albums = Work.list_by_votes("album")
    @movies = Work.list_by_votes("movie")

    @top_work = (@works.all.sample(1))[0]
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
    id = params[:id]
    @work = Work.find_by(id: id)
    @work.update(work_params)

    if @work.save
      redirect_to work_path # go to the index so we can see the book in the list
    else
      render :new
    end
  end

  def create
    if @current_user.nil?
      flash[:warning] = "You must be logged in to vote"
    elsif
    @work = Work.new(work_params)
      if @work.save
        flash[:success] = "New work created"
        redirect_to work_path(@work.id)
      else # save failed :(
        flash.now[:error] = 'Work not created'
        @work.errors.messages.each do |field, messages|
          flash.now[field] = messages
        end
        render :new, status: 400 # show the new book form view again
      end
  end

  def upvote
    id = params[:id]
    @work = Work.find_by(id: id)
    if @current_user
      @work.upvote(user_id: @current_user.id)
      flash[:success] = "Your vote was added"
      redirect_to works_path
    else
      flash[:warning] = "You must be logged in to vote"
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
