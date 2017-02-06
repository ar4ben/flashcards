class OauthsController < ApplicationController
  skip_before_filter :require_login
  skip_before_filter :set_locale

  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if login_from(provider)
      redirect_to root_path, notice: "#{t('notice.enter')} #{provider.titleize}!"
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        redirect_to root_path, notice: "#{t('notice.enter')} #{provider.titleize}!"
      rescue
        redirect_to root_path, alert: "#{provider.titleize} - #{t('alert.login')}!"
      end
    end
  end
end
