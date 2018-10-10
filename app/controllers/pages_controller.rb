class PagesController < ApplicationController
  def show
    if params[:page] == "home"
      @media = Medium.all
      @media_spotlight = Medium.spotlight
    end

    render template: "pages/#{params[:page]}"
  end
end
