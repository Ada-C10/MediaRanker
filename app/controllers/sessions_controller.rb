class SessionsController < ApplicationController

  def index
    @work = Work.all
  end

  def new
  end

  def create
    name = params[:username]
    user = User.find_by(username: name)

    if user
      flash[:success] = "Successfully logged in as #{name}"
      session[:user_id] = user.id
    else
      user = User.new(name)
      is_successful_save = user.save

      if is_successful_save
        session[:user_id] = user.id
        flash[:success] = "Successfully logged in as #{name}"
      else
        render :new, status: :bad_request
      end

    end
    redirect_to home_page

  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end



end
