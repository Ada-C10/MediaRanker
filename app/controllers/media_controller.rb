class MediaController < ApplicationController

  before_action :find_medium, except: [:index, :new, :create]

  def index
    @movies = Medium.where(category: "movie")
    @books = Medium.where(category: "book")
    @albums = Medium.where(category: "album")
  end

  def show
    if @medium.nil?
      head :not_found
    end
  end

  def new
    @medium = Medium.new
  end

  def create
    @medium = Medium.new(medium_params)

    if @medium.save
      flash[:success] = "Successfully added a new #{@medium.category} to the database!"
      redirect_to medium_path(@medium)
    else
      flash.now[:error] = "Something went wrong here bro.. Try filling out all the fields yeah?"
      render :new, status: :bad_request
    end
  end

  def edit
  end

  def update
    if @medium.update(medium_params)
      redirect_to medium_path(@medium.id)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    @medium.destroy
    redirect_to media_path
  end

  private

  def medium_params
    return params.require(:medium).permit(
      :title,
      :description,
      :category,
      :creator,
      :publication_year
    )
  end

  def find_medium
    @medium = Medium.find_by(id: params[:id])
  end

end
