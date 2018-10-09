class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end

  def show
    @vote = Vote.find_by(id: params[:id])
  end

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new(vote_params)

    if @vote.save
      redirect_to votes_path
    else
      render :new, status: :bad_request
    end
  end

  def edit
    @vote = Vote.find_by(id: params[:id])
  end

  def update
    @vote = Vote.find_by(id: params[:id])
    if @vote.update(vote_params)
      redirect_to vote_path(vote.id)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    @vote = Vote.find_by(id: params[:id])
    @vote.destory

    redirect_to votes_path 
  end

  private

  def vote_params
    return params.require(:vote).permit(
      :count,
      :user_id,
      :work_id
    )
  end
end
