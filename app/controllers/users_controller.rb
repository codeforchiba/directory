class UsersController < ApplicationController
  skip_before_action :require_login

  def new
    @user = User.new

    session[:oauth_usage] = "registration"
  end

  def create
    @user = User.new(user_params)

    if @user.save
      reset_session
      auto_login(@user)

      redirect_to root_path
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
