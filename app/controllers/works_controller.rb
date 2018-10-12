class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def home

  end

  def index
    @books = Work.by_category("book")
    @albums = Work.by_category("album")
    @movies = Work.by_category("movie")

  end

  def show; end


  def new
    @work = Work.new
  end

  def edit; end


  def destroy

    if !@work.nil?
      @work.destroy
      flash[:success] = "#{work.title} deleted"
      redirect_to root_path
    end
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = 'Work Created!'

      redirect_to root_path
    else
      flash.now[:error] = 'Work not created!'
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end

      render :new
    end
  end

  def update

    if @work && @work.update(work_params)
      redirect_to work_path(@work.id)
    elsif @work
      render :edit
    end
  end

  # def create
  #   if params[:work_id]
  #     work = Work.find_by(id: params[:work_id])
  #
  #     @vote = work.votes.new
  #     @vote.user_id = @current_user.id
  #
  #   else
  #     @vote = Vote.new
  #   end
  #
  #   if @vote.save
  #     redirect_to work_path(id: work.id)
  #   else
  #     redirect_back fallback_location: root_path
  #   end
  # end


private

  def find_work
    @work = Work.find_by(id: params[:id].to_i)

    if @work.nil?
      flash[:warning] = "cannot find #{@work.title}"
      redirect_to works_path
    end
  end

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end


end
