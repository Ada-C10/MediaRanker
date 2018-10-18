class WorksController < ApplicationController

  before_action :category_from_work, except: [:homepage, :index, :new, :create]
  #lets you know the category of work before running controller action
  def homepage
    @albums = Work.highest_albums #highest votes for album
    @books = Work.highest_books #highest votes for book
    @movies = Work.highest_movies #highest votes for movie
    @best_work = Work.order(vote_count: :desc).first #highest votes overall
  end

  def index
    @works_by_category = Work.to_category_hash #Work's category
    # @works = Work.all
  end

  def show
    id = params[:id].to_i
    @work = Work.find(params[:id].to_i) #if work id is found, assign to @work
    @votes = @work.votes.order(created_at: :desc) #@votes = work's votes in descending order

    # if id.nil?
    #   render :notfound
    # end
  end

  def new
    @work = Work.new #new work
  end

  def edit
    id = params[:id].to_i #work's id
    @work = Work.find(params[:id].to_i) #if found, assign it to @work
  end

  def update
    id = params[:id].to_i #work's id
    @work = Work.find_by(id: id) #if found, assign it to @work
    @work.update(work_params) #update work

    if @work.save
      flash[:success] = "#{@work.category} is updated!" #success msg displayed of saved
      redirect_to works_path
    else
      flash.now[:error] = "Not updated!" #error msg displayed if work is not saved due to validations
      render :edit
    end
  end

  def create
    @work = Work.new(work_params)
    @work_category = @work.category
    if @work.save # save returns true if the database insert succeeds
      flash[:success] = "#{@work_category} is created!"

      redirect_to root_path # for now
    else # save failed :(
      flash.now[:error] = "Not created!"
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end

      render :new # show the new work from view again
    end
  end


  def destroy
    id = params[:id].to_i
    @work = Work.find_by(id: id)
    if @work.destroy
      flash[:success] = "#{@work_category} is deleted"
      redirect_to root_path
    end
  end
  #
  # def create
  #   @work = Work.find(params[:id])
  #   @work = User.find(params[:id])
  #   @work.votes.create
  #   redirect_to(works_path)

    #
    # if @work.upvote(@current_user)
    #   flash[:success] = "Vote successful."
    # else
    #   flash[:warning] = "Unable to submit vote"
    # end
    #
    # redirect_back fallback_location: works_path
  # end





  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :published_year, :description)
  end

  def category_from_work
    if @work = Work.find_by(id: params[:id]) #if work id is found...
      @work_category = @work.category.downcase.pluralize #work's category is downcased and pluralize and assigned to @work_category
    else
      flash.now[:error] = "Error!"
    end
  end
end
