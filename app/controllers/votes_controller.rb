class VotesController < ApplicationController
  validates :work_id, presence: true, uniqueness: { scope: :user_id, message: "has already voted for this work" }
  # def index
  #   @votes = Votes.all.order(:title)
  # end
  #
  # def show
  #   id = params[:id]
  #   @vote = Votes.find_by(id: id)
  #
  #   if @vote.nil?
  #     render :notfound, status: :not_found
  #   end
  # end

  def new
    @vote = Vote.new
  end

  def create
    @vote = Votes.new(vote_params)
    if @vote.save
      redirect_to vote_path(@vote.id)
    else
      render :new
    end
  end

  # def edit
  #   @vote = Votes.find_by(id: params[:id])
  # end
  #
  #
  # def update
  #   @vote = Votes.find_by(id: params[:id])
  #   if @vote.update(vote_params)
  #     redirect_to vote_path(@vote.id)
  #   end
  # end
  #
  # def destroy
  #   vote = Votes.find_by(id: params[:id])
  #   vote.destroy
  #   redirect_to votes_path
  # end

  private

  def vote_params
    return params.require(:vote).permit(:title)
  end
end
