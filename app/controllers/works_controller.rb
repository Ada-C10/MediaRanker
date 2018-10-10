class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def home

  end

  def index
    @books = Work.by_category("Book")
    @Albums = Work.by_category("Album")
    @Movies = Work.by_category("Movie")
    
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
