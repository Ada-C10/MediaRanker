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
  end

  def show
  end

  def destroy
    # Flash notice for success/failure
  end

end
