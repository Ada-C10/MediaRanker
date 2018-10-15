class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy, :upvote]

  def index
    @works = Work.all
  end

  def show; end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "Work Created!"
      redirect_to work_path(@work .id)
    else
      flash.now[:warning] = "A problem occurred: Work not created."
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :new
    end
  end

  def edit; end

  def update
    if @work && @work.update(work_params)
      flash[:success] = "Work Updated!"
      redirect_to work_path(@work .id)
    else
      flash.now[:warning] = "A problem occurred:  Work not edited."
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :edit
    end
  end

  def destroy
    if !@work.nil?
      @work.destroy
      flash[:success] = "Work #{@work.id} deleted!"
      redirect_to root_path
    end
  end

  def upvote
    if @current_user
      vote = Vote.new(work_id: @work.id, user_id: @current_user.id, date: Date.today)
      if  vote.save
        flash[:success] = "Successfully upvoted!"
      else
        flash[:warning] =" A problem occurred: Could not upvote"
        vote.errors.messages.each do |field, messages|
          flash[field] = messages
        end
      end
      redirect_to work_path(@work .id)
    else
      flash[:warning] = "A problem occurred:  You must be logged in to do that!"
      redirect_to works_path
    end
  end

  private

  def work_params
    return params.require(:work).permit(:title, :description, :publication_year, :creator, :category)
  end

  def find_work
    @work = Work.find_by(id: params[:id].to_i)
    if @work.nil?
      flash.now[:warning] = "A problem occurred: Unable to find work."
      render :not_found
    end
  end

end
