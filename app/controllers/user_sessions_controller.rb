class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if login(session_params[:email], session_params[:password])
      redirect_back_or_to(root_path, notice: t('notice.success'))
    else
      flash.now[:alert] = t('alert.login')
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(root_path, notice: t('notice.exit'))
  end

  private

  def session_params
    params.require(:user_sessions).permit(:email, :password)
  end
end
