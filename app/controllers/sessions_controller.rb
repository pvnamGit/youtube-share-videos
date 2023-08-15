class SessionsController < ApplicationController

  def index

  end

  def create
    user = User.find_by(username: login_params[:username])
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      cookies.signed[:user_id] = user.id
      redirect_to root_path
    else
      flash[:alert] = "Wrong password or username. Try again"
      redirect_to sessions_path
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to root_path
  end

  private

  def login_params
    params.permit(:username, :password)
  end
end
