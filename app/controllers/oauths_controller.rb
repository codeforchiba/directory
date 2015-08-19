class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    unless auth_params.has_key? :error
      provider = auth_params[:provider]

      begin
        unless @user = login_from(provider)
          @user = create_from(provider)

          reset_session
          auto_login(@user)
        end

        redirect_to root_path
      rescue => e
        logger.error e

        redirect_to return_path, alert: I18n.t("errors.messages.facebook_not_authorized")
      end
    else
      message = auth_params[:error_description] || auth_params[:error_message]
      logger.error "[#{auth_params[:error_code]}] #{auth_params[:error]} #{message}"

      redirect_to return_path, alert:  I18n.t("errors.messages.facebook_not_authorized")
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :error, :error_code, :error_description, :error_reason, :error_message)
  end

  def return_path
    session[:oauth_usage] == "registration" ? sign_up_path : log_in_path
  end
end
