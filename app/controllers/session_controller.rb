class SessionController < ApplicationController
  before_action :logged_in_redirect, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(username: params_user_name)
    if user && user.authenticate(params_user_password)
      session[:user_id] = user.id
      flash[:success] = "Logged in succesfully!"
      redirect_to root_path
    else
      flash.now[:error] = " Wrong username or password submited. Try again please!"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash.now[:success] = "You have succesfully Logged Out from the application!"
    render 'new'
  end

  private

  def params_user_name
    params[:session][:username]
  end

  def params_user_password
    params[:session][:password]
  end

  def logged_in_redirect
    if logged_in?
      flash[:error] = "You are already logged in."
      redirect_to root_path
    end
  end
end