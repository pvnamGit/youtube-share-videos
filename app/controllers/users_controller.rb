class UsersController < ApplicationController

  def index
  end

  def create
    check_existed_user = User.find_by(username: register_user_params[:username])
    if check_existed_user
      flash[:alert] = "Username #{register_user_params[:username]} already created"
      redirect_to users_path and return
    end

    if register_user_params[:password] != register_user_params[:password_confirmation]
      flash[:alert] = "Wrong confirmation password"
      redirect_to users_path and return
    end

    @user = User.new(register_user_params)
    if @user.save
      session[:current_user_id] = @user.id
      redirect_to root_path
    end
  end

  private

  def register_user_params
    params.permit(:username, :password, :password_confirmation)
  end
end
