class WorksController < ApplicationController
  before_action :find_work, only:[:show, :edit, :update, :destroy, :upvote]

  def main
    @works = Work.all
  end

  def show; end

  def index
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "Successfully created #{@work.category} #{@work.title}!"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = 'Work not added'
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
  elsif @work
    render :edit
  end
end


  def destroy
    unless @work.nil?
      # if @work.votes.count > 0
      #   @work.votes do |vote|
      #     vote.destroy
      #   end
      # end
      @work.destroy
      flash[:success] = "#{@work.title} deleted"
      redirect_to root_path
    end
  end

  def upvote
    if @current_user.nil?
      flash[:warning] = "You must be logged in to vote"
      redirect_to root_path
    else
      @upvote = Vote.new(user_id: @current_user.id, work_id: @work.id)
      if @upvote.save
        flash[:message] = "Vote added to #{@work.title}"
        redirect_to works_path
      else
        flash[:warning] = "A problem occurred: #{@current_user.username.capitalize} has already voted for this work"
        redirect_to work_path
      end
    end
  end

private

  def find_work
    @work = Work.find_by(id:params[:id].to_i)
    if @work.nil?
      flash.now[:warning] = 'Cannot find work'
      render :notfound
    end
  end

  def work_params
    return params.require(:work).permit(:title, :publication_year, :creator, :description, :category)
  end
end
