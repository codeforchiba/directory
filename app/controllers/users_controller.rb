class UsersController < ApplicationController
  skip_before_action :require_login

  def new
    @user = User.new

    session[:oauth_usage] = "registration"
  end

  def create
    @user = User.new(user_params)

    if @user.save(context: :with_password)
      reset_session
      auto_login(@user)

      redirect_to root_path
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def embedded
    @user = User.find_by(uuid: params[:id])

    if @user.present?
      render layout: "embed"
    else
      render nothing: true, status: 404
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
