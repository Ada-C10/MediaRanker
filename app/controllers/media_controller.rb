class MediaController < ApplicationController
  def index
    @movies = Medium.where(category: "movie")
    @books = Medium.where(category: "book")
    @albums = Medium.where(category: "album")
  end

  def show
    @medium = Medium.find_by(id: params[:id])
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
      render :new, status: :bad_request
    end
  end

  def edit
    @medium = Medium.find_by(id: params[:id])
  end

  def update
    medium = Medium.find(params[:id])
    if medium.update(medium_params)
      redirect_to medium_path(medium.id)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    medium = Medium.find_by(id: params[:id])

    medium.destroy
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
end
