class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all #.order(:votes)
  end

  def show; end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "Media Added!"
      redirect_to works_path
    else
      flash.now[:warning] = "Media not Added!"
      @work.errors.messages.each do |field, msg|
        flash.now[field] = messages
      end

      render :new
    end
  end

  def edit; end

  def update
    if @work && @work.update(work_params)
      flash[:success] = "#{@work.title} was edited."
      redirect_to work_path(@work.id)
    elsif @work
      flash.now[:warning] = @work.errors.messages
      render :edit
    end
  end

  def destroy
    unless @work.nil?
      @work.destroy
      flash[:success] = "#{@work.title} deleted"
      redirect_to works_path
    end
  end

  def top_media
  end

  private

  def find_work
    @work = Work.find_by_id(params[:id])

    if @work.nil?
      flash.now[:warning] = "Cannot find the media #{params[:title]}"
      render :notfound
    end
  end

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
