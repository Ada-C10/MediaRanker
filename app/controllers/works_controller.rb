class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all.order(:title)

    medias = ['albums','movies','books']

    medias.each do |media|
      media = Work.all.order(:title).select {|work| work.category == media}
    end


  end

  def main
    @works = Work.all.order(:title)
  end

  def show; end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = 'Work Created!'
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = 'Work could not be created!'
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :new
    end

  end

  def edit; end


  def update
    if @work && @work.update(work_params)
      redirect_to work_path(@work.id)
    elsif @book
      render :edit
    end
  end

  def destroy
    if !@work.nil?
      @work.destroy
      flash[:success] = "#{@work.title} deleted"
    end
    redirect_to works_path
  end

  private

  def find_work
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      flash.now[:warning] = "Work #{params[:id]} not found"
      render :notfound
    end
  end


  def work_params
    return params.require(:work).permit(:title,:category,:publication_year,:description)
  end
end
