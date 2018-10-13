class UsersController < ApplicationController
  def new
  end

  def create
    name = params[:name]
    user = User.find_by(name: name)

    if user
      flash[:success] = "Ur logged tf in, #{name}! (also ur my bro)"
      session[:user_id] = user.id
      redirect_to root_path
    else
      user = User.create(name: name)

      if user.save
        flash[:success] = "New account created. Welcome tf to our site, #{name} (also ur my bro now, js)"

        session[:user_id] = user.id
        redirect_to root_path
      else
        flash.now[:error] = "uh oh bro, looks like something went wrong..."
        render :new
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Ur logged tf out, bro!! high five!"
    redirect_to root_path
  end

  def upvote
    if Vote.create(user_id: session[:user_id], medium_id: params[:id])
      flash[:success] = "bro nice upvote! i saw that!! high five for the positivity bro.."
      redirect_to medium_path(params[:id])
    else
      flash.now[:error] = "uh bro something did not work sorry :/"
      render :template => "media/show(#{params[:id]})"
    end
  end

end
