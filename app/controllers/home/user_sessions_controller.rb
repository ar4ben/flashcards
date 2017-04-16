class Home::UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if login(session_params[:email], session_params[:password])
      redirect_back_or_to(dashboard_root_path, notice: t('.success'))
    else
      flash.now[:alert] = t('.login')
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(dashboard_root_path, notice: t('.exit'))
  end

  private

  def session_params
    params.require(:user_sessions).permit(:email, :password)
  end
end
