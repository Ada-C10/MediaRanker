class PagesController < ApplicationController
  def show
    @media = Medium.all
    render template: "pages/#{params[:page]}"
  end
end
