class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy, :upvote]

  def index
    @works = Work.all.order(:title)
  end

  def show; end

  def new
    @work = Work.new
  end

  def edit; end

  def destroy
    unless @work.nil?
      @work.destroy
      flash[:success] = "#{@work.title} deleted"

      redirect_to work_path(@word.id)
    end
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "Successfuly created #{@work.category} #{@work.id}"

      redirect_to works_path
    else
      flash.now[:warning] = 'Work not created'
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end

      render :new
    end
  end

  def update
    if @work && @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    elsif @work
      flash.now[:warning] = "A problem occured: could not update #{@work.category}"
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end

      render :edit
    end
  end

  def upvote
    if @current_user.nil?
      flash[:warning] = "A problem occured: You must log in to do that"
      redirect_back fallback_location: work_path(@work.id)

    elsif @current_user.votes.find_by(work_id: @work.id).nil?
      @vote = Vote.new(quantity: 1, user_id: @current_user.id, work_id: @work.id)

      if @vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_back fallback_location: works_path
      end
    else
      flash[:warning] = "A problem occurred: Could not upvote"
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      redirect_back fallback_location: work_path(@work.id)
    end
  end

  private

  def find_work
    @work = Work.find_by(id: params[:id].to_i)

    if @work.nil?
      flash[:warning] = 'Cannot find the work'
      redirect_to root_path
    end
  end

    def work_params
      return params.require(:work).permit(:title, :creator, :publication_year, :description, :category)
    end
end
