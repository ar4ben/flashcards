class Dashboard::DecksController < ApplicationController
  before_action :set_deck, only: [:edit, :show, :update, :destroy]

  def index
    @decks = current_user.decks.all
  end

  def new
    @deck = current_user.decks.new
  end

  def edit
  end

  def create
    @deck = current_user.decks.new(decks_params)
    if @deck.save
      redirect_to dashboard_root_path
    else
      render 'new'
    end
  end

  def show
  end

  def update
    if @deck.update(decks_params)
      redirect_to @deck
    else
      render 'edit'
    end
  end

  def destroy
    @deck.destroy
    redirect_to dashboard_decks_path
  end

  private

  def decks_params
    params.require(:deck).permit(:name)
  end

  def set_deck
    @deck = current_user.decks.find_by(id: params[:id])
    redirect_to dashboard_root_path unless @deck
  end
end
