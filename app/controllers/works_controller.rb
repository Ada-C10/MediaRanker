class WorksController < ApplicationController


  def index
    # Order by vote count
    @works = Work.all
  end


  def new

  end

  def create
    # @work = Work.new(work_params)
    # if @work.save
    # Do a flash notice if save is successful
    # flash[:success] = "Work Created!"
    # else
      # flash[:failure] = "Work not created"
    # Failed = flash.now[:error] = 'Work not created'
    # Loop through @work.errors.messages.each do |field, messages|
    # flash.now[field] = messages
  # end
  # This shows the error messages in flash
  end

  def update
  end

  def edit
    id = params[:id].to_i
    @work = Work.find_by(id: id)
  end

  def show
    id = params[:id].to_i
    @work = Work.find_by(id: id)

    if @work.nil?
      render :notfound, status: :not_found
    end
  end

  def destroy
    # Flash notice for success/failure
    id = params[:id].to_i
    work = Work.find_by(id: id)
    if work.nil?
      flash[:error] = "Work #{params[:id]} not found"
    else
      @deleted_work = work.destroy
      flash[:success] = "#{work.title} deleted"
    end

    redirect_to root_path 
  end

end
