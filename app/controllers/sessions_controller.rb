class SessionsController < ApplicationController
  skip_before_action :require_login, except: [ :destroy ]

  def new
    @user = User.new

    session[:oauth_usage] = "login"
  end

  def create
    @user = login(auth_params[:email], auth_params[:password])

    if @user.present?
      redirect_to root_path
    else
      @user = User.new(email: auth_params[:email])

      flash.now[:alert] = I18n.t("errors.messages.login_failed")
      render "new"
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

  private

  def auth_params
    params.require(:user).permit(:email, :password)
  end
end
