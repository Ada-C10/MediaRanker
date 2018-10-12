class WorksController < ApplicationController
  def index
    @works = Work.all
  end
  def show
    @work = Work.find(params[:id])

    if @work.nil?
      render :notfound, status: :not_found
    end
  end
  def new
    @work = Work.new
  end

  def create
    @work = Wook.new(work_params)

   if @work.save
      redirect_to :action => 'list'
   else
      @subjects = Subject.all
      render :action => 'new'
   end
  end

  def edit
    @work = Work.find(params[:id].to_i)
  end

  def update
  end

  def delete
  end
  def work_params
   params.require(:works).permit(:category, :title, :creator, :publication_year, :description)
end
end
