class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def home
    @works = Work.all
    @works_hash = Work.list_all_works
    @top_ten_hash = Work.top_ten(@works_hash)
    @spotlight = Work.spotlight(@top_ten_hash)
  end

  def index
    @works = Work.list_all_works
  end

  def show
    if session[:user_id]
      @vote = @work.votes.find_by(user_id: session[:user_id])
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save # save returns true if the database insert succeeds
      flash[:success] = "Succesfully created new #{@work.category} \"#{@work.title}!\""
      redirect_to works_path # go to the index so we can see the book in the list
    else # save failed :(
      flash[:error] = "Work not created!"
      @work.errors.messages.each do |field, messages|
        flash[field] = messages
      end
      redirect_to new_work_path
      # I think we're supposed to use render :new, but I want the url to change...?
    end
  end

  def edit; end

  def update
    if @work && @work.update(work_params)
        flash[:success] = "Succesfully edited #{@work.category} \"#{@work.title}!\""
      redirect_to work_path(@work.id)
    elsif @work
      flash[:error] = "Work edits not saved!"
      @work.errors.messages.each do |field, messages|
        flash[field] = messages
      end
      render :edit
    end
  end

  def destroy
    unless @work.nil?
      @deleted_work = @work.destroy
      flash[:success] = "#{@work.title} deleted"
      redirect_to root_path
    end
  end

  private

# Filter for #show, #edit, #update, #destroy
  def find_work
    @work = Work.find_by(id: params[:id].to_i)
    if @work.nil?
      flash.now[:warning] = 'Cannot find the work'
      render :notfound, status: :not_found
    end
  end

  def work_params
    return params.require(:work).permit(:title, :creator, :publication, :category, :description)
  end

end
