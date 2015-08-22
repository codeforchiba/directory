class ProfileController < ApplicationController

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(user_params)
      redirect_to profile_path, notice: I18n.t("messages.common.updated")
    else
      render "edit"
    end
  end

  def password
    @user = current_user
  end

  def update_password
    @user = current_user

    if @user.password.nil? || @user.valid_password?(password_params[:current_password])
      @user.attributes = password_params

      if @user.save(context: :with_password)
        redirect_to profile_path, notice: I18n.t("messages.common.password_changed") and return
      end
    end

    render "password"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :about)
  end

  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
