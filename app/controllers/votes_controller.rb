class VotesController < ApplicationController

  def index
    @votes = Vote.all.order(:title)
  end

  def show
    id = params[:id]
    @vote = user.find_by(id: id)

    if id == nil
      render :not_found, status: :not_found
    end

  end

  def edit
    id = params[:id]
    @vote = Vote.find_by(id: id)
  end

  def new
    @vote = Vote.new
  end


  def update
    id = params[:id]
    @vote = Vote.find_by(id: id)
    @vote.update(vote_params)

    if @vote.save
      redirect_to vote_path
    else
      render :new
    end
  end

  def create
    @vote = Vote.new(:id)
    if @vote.save
      redirect_to vote_path
    #   render :new # show the new book form view again
    end
  end

  def destroy
    id = params[:id]
    @vote = Vote.find_by(id: id)
    if @vote.destroy
      redirect_to root_path
    end
  end

end

private

  def vote_params
    return params.require(:vote).permit(:user_id, :work_id)
  end
