class OauthsController < ApplicationController
  skip_before_filter :require_login

  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if login_from(provider)
      redirect_to root_path, notice: "Вы вошли через #{provider.titleize}!"
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        redirect_to root_path, notice: "Вы вошли через #{provider.titleize}!"
      rescue
        redirect_to root_path, alert: "Ошибка логина через #{provider.titleize}!"
      end
    end
  end
end
