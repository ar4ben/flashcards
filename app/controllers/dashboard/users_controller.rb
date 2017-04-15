class Dashboard::UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :new, :create]
  before_action :set_user, only: [:edit, :update, :set_current_deck]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(user_params[:email], user_params[:password])
      redirect_to dashboard_root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to dashboard_root_path
    else
      render 'edit'
    end
  end

  def set_current_deck
    if @user.update_attribute(:deck_id, params[:deck_id])
      redirect_to dashboard_deck_path(params[:deck_id])
    else
      redirect_to dashboard_root_path, notice: t('.wrong')
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :locale)
  end

  def set_user
    @user = User.find(params[:id])
    redirect_to dashboard_root_path unless @user == current_user
  end
end
