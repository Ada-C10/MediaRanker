class VotesController < ApplicationController

  def create
     @vote = Vote.new(vote_params)
     @vote.work = Work.find(params[:work_id])
     if @vote.save
       respond_to do |format|
         format.html { redirect_to @vote.work }
       end
     end
   end

  def index
    @votes = Vote.all
  end

  def edit
    @vote = Vote.find_by(id: params[:id])
  end

  def new
    @vote = Vote.new
  end

  def destroy
    vote = Vote.find_by(id: params[:id])
    vote.destroy
    redirect_to root_path
  end

  def show
    vote_id = params[:id]
    @vote= Vote.find_by(id: work_id)
    if @vote.nil?
      head :not_found
    end
  end

  def update
    @vote = Vote.find(params[:id])
    @vote.update(work_params)
    redirect_to works_path
  end

  private

  def vote_params
    return params.permit(
      :user,
      :work_id)
  end

end
