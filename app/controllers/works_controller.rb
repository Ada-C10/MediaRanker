class WorksController < ApplicationController
  def home
  end
  
  def index
  @works = Work.all.order(:id)
end

def show
  id = params[:id].to_i
  @work = Work.find_by(id: id)

  if @work.nil?
   render :notfound, status: :not_found
  end
end

def new
  @work = Work.new
end

def edit
  @work = Work.find(params[:id].to_i)
end

def destroy
  work = Work.find_by(id: params[:id].to_i)
  if work.nil?
    flash[:error] = "Work #{params[:id]} not found"
  else
    @deleted_work = work.destroy
    flash[:success] = "#{work.title} deleted"
  end

  redirect_to root_path
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
  @work = Work.find_by(id: params[:id].to_i)
  if @work.update(work_params)
    redirect_to work_path(@work.id)
  else
    render :edit
  end
end



private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end


end
