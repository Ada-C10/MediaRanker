class VotesController < ApplicationController
  before_action :find_vote, only: [:show, :edit, :update, :destroy]

  def index
    @votes = Vote.all
  end

  def show
    if @vote.nil?
      head :not_found
    end
  end

  def new
    @vote = Vote.new
  end

  def create
    if params[:user_id]
      @vote = Vote.new(vote_params)

      if @vote.save
        redirect_to votes_path
      else
        render :new, status: :bad_request
      end
    else
      render :new, status: :bad_request
    end
  end

  def edit
  end

  def update
    if @vote.update(vote_params)
      redirect_to vote_path(vote.id)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
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

  def find_vote
    @vote = Vote.find_by(id: params[:id])
  end
end
