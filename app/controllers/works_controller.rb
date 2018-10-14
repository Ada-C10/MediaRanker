class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all
  end

  def show; end

  def new
      @work = Work.new
  end

  def edit; end

  def update
    if @work && @work.update(work_params) #(if user exists AND can be updated)
      # @work.user_id = session[:user_id]
      flash[:success] = "#{@work.title} has been edited."
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = 'Sorry, no edits were saved.'
      render :edit
    end
  end

  def create
    @work = Work.new(work_params)
    if @work.save # save returns true if the database insert succeeds
      flash[:success] = "#{@work.title} has been added to the site."
      redirect_to root_path
    else
      flash.now[:error] = 'Work has not been added!'
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :new # show the new work form view again
    end

  end

  def sort_category #sorting categories for view

  end

  def destroy
    if @work != nil
      work = @work.destroy #to temp store work instance for title below
      flash[:success] = "#{work.title} has been removed from the site."
      redirect_to root_path
    end

  end

  private

  def find_work
    id = params[:id].to_i
    @work = Work.find_by(id: id)

    if @work.nil?
      flash.now[:warning] = "Sorry, we can't find what you are looking for."
     render :not_found
    end
  end

  def work_params
    return params.require(:work).permit(:id, :creator, :category, :year, :description, :title, :user_id)
  end
end
