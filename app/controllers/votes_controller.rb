class VotesController < ApplicationController
  def new
    @vote = Vote.new
  end

  def index
    @votes = Vote.all
  end

  def create
    @vote = Vote.new
    if @vote.save
      flash[:success] = 'Vote added!'
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = 'Work not added'
      @vote.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :new
    end
  end

  def destroy
    unless @vote.nil?
      @vote.destroy
      flash[:success] = "Vote deleted"
      redirect_to root_path
    end
  end

end
